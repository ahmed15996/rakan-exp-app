import 'dart:async';
import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:flutter/widgets.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:injectable/injectable.dart';
import 'package:pusher_channels_flutter/pusher_channels_flutter.dart';
import 'package:rakaan/features/home/data/models/home_model.dart';
import 'package:rakaan/features/home/data/param/online_param.dart';

import '../../../../core/constants/app_cached.dart';
import '../../../../core/helpers/custom_location_helper.dart';
import '../../../../core/local/shared_preferences/shared_pref_services.dart';
import '../../../../core/widgets/custom_toast.dart';
import '../../data/param/location_param.dart';
import '../../data/repository/home_repository.dart';

part 'home_state.dart';

@injectable
class HomeCubit extends Cubit<HomeState> {
  HomeCubit(this.repository, this.pref) : super(HomeInitial());
  final HomeRepository repository;
  final SharedPrefServices pref;
  LatLng? currentLocation;
  LatLng defaultLocation = const LatLng(21.437273, 40.512714);
  Completer<GoogleMapController> mapController = Completer<GoogleMapController>();
  GoogleMapController? googleMapController;

  final currentLocationNameCtrl = TextEditingController();
  final Set<Marker> markers = {};
  bool haveTrip = false;
  bool isOpenOnlineSheet = false;

  HomeModel? model;

  /// update online
  void updateOnline({required int isOnline}) async {
    emit(UpdateOnlineLoading());
    var result = await repository.updateOnline(param: OnlineParam(isOnline: isOnline));
    result.fold((failure) {
      emit(UpdateOnlineFailed(msg: failure.message));
    }, (data) {
      model?.online = !(model?.online ?? false);
      emit(UpdateOnlineSuccess(msg: data));
    });
  }

  /// update location
  Future<void> updateLocation() async {
    if (currentLocation == null) {
      await checkPermission().then(
        (value) async {
          emit(UpdateLocationLoading());
          var result = await repository.updateLocation(
              param: LocationParam(
                  lat: currentLocation!.latitude.toString(),
                  long: currentLocation!.longitude.toString(),
                  address: currentLocationNameCtrl.text));
          result.fold((failure) {
            emit(UpdateLocationFailed(msg: failure.message));
          }, (data) {
            getTrip();
            emit(UpdateLocationSuccess(msg: data));
          });
        },
      );
    } else {
      emit(UpdateLocationLoading());
      var result = await repository.updateLocation(
          param: LocationParam(
              lat: currentLocation!.latitude.toString(),
              long: currentLocation!.longitude.toString(),
              address: currentLocationNameCtrl.text));
      result.fold((failure) {
        emit(UpdateLocationFailed(msg: failure.message));
      }, (data) {
        getTrip();
        emit(UpdateLocationSuccess(msg: data));
      });
    }
  }

  /// get current trip
  void getTrip() async {
    emit(GetTripLoading());
    var result = await repository.getTrip();
    result.fold((failure) {
      emit(GetTripFailed(msg: failure.message));
    }, (data) async {
      model = data;
      haveTrip = true;

      await initPusher();

      emit(GetTripSuccess());
    });
  }

  void onMapCreate(GoogleMapController controller) async {
    if (!mapController.isCompleted) {
      mapController.complete(controller);
      googleMapController = await mapController.future;
      emit(HomeUpdate());
    }
  }

  Future<void> checkPermission() async {
    if (currentLocationNameCtrl.text.isEmpty) {
      emit(CurrentLocationLoading());
      await Geolocator.requestPermission();
      bool serviceEnabled = await LocationHelper.isServiceEnabled();
      bool serviceHavePermission = await LocationHelper.isServiceHavePermission();
      if (serviceEnabled && serviceHavePermission) {
        return getCurrentLocation();
      } else if (!serviceEnabled && serviceHavePermission) {
        return getCurrentLocation();
      } else if (serviceEnabled && !serviceHavePermission) {
        await LocationHelper.requestLocationPermission(
          onFinish: () async {
            bool serviceHavePermission = await LocationHelper.isServiceHavePermission();
            if (serviceHavePermission) {
              return getCurrentLocation();
            }
          },
        );
      } else {
        await LocationHelper.requestLocationPermission(
          onFinish: () async {
            bool serviceHavePermission = await LocationHelper.isServiceHavePermission();
            if (serviceHavePermission) {
              return getCurrentLocation();
            }
          },
        );
      }
    }
  }

  void getCurrentLocation() async {
    try {
      Position position = await LocationHelper.getCurrentPosition();
      currentLocation = LatLng(position.latitude, position.longitude);
      Placemark placeMark = await LocationHelper.getLocationInfo(currentLocation!);
      currentLocationNameCtrl.text =
          "${placeMark.name}, ${placeMark.subLocality}, ${placeMark.locality}, ${placeMark.administrativeArea}, ${placeMark.country}";

      googleMapController!.animateCamera(CameraUpdate.newCameraPosition(CameraPosition(target: currentLocation!, zoom: 13)));

      emit(CurrentLocationSuccess());
    } catch (error) {
      emit(CurrentLocationFailed(msg: error.toString()));
    }
    updateLocation();
  }

  void onUpdateCamera({required CameraPosition position}) async {
    currentLocation = position.target;
  }

  update() {
    emit(HomeUpdate());
  }

  openOnlineSheet() {
    isOpenOnlineSheet = !isOpenOnlineSheet;
    emit(HomeUpdate());
  }

  /// Pusher setup
  late final PusherChannelsFlutter pusher = PusherChannelsFlutter.getInstance();
  bool _pusherConnected = false;

  Future<void> initPusher() async {
    var id = pref.getData(key: AppCached.id) ?? "";
    if (_pusherConnected) {
      debugPrint("Pusher already connected, skipping init.");
      return;
    }

    try {
      debugPrint("Initializing Pusher...");

      await pusher.init(
        apiKey: "3f9d157327ca3f3c9e88",
        cluster: "eu",
        onConnectionStateChange: (currentState, previousState) {
          debugPrint("Pusher state changed: $previousState → $currentState");
        },
        onError: (message, code, error) {
          debugPrint("Pusher error: $error | Message: $message | Code: $code");
        },
        onSubscriptionSucceeded: (channelName, data) {
          debugPrint("Subscribed to channel: $channelName | Data: $data");
        },
        authParams: {
          'params': {'foo': 'bar'},
          'headers': {'baz': 'boo'}
        },
        onEvent: (event) async {
          debugPrint("Event received: ${event.eventName}");

          if (event.eventName == "OfferSent") {
            debugPrint("event data: ${event.data}");
            await listen(data: event.data);
          }
        },
      );

      await pusher.subscribe(channelName: 'offer.$id');
      await pusher.connect();
      _pusherConnected = true;
      debugPrint("Pusher connected successfully.");
    } catch (e, stack) {
      debugPrint("Pusher init error: $e");
      debugPrint(stack.toString());
    }
  }

  Future<void> listen({required dynamic data}) async {
    try {
      if (data == null) {
        debugPrint("Pusher event data is null, ignoring.");
        return;
      }

      // لو جاي String نحوله لـ Map
      if (data is String) {
        try {
          data = jsonDecode(data);
          debugPrint("success to decode event data: $data");
        } catch (decodeError) {
          debugPrint("Failed to decode event data: $decodeError");
          return;
        }
      }

      // هنا نتأكد إنه Map
      if (data is Map<String, dynamic>) {
        // لو فيه مفتاح data
        if (data.containsKey('data') && data['data'] != null) {
          model = HomeModel.fromJson(data['data']);
        } else {
          // الحالة الجديدة: البيانات كلها في الـ root
          model = HomeModel.fromJson(data);
        }
        debugPrint("Model updated from Pusher event.");
        emit(SocketUpdateState());
      } else {
        debugPrint("Event data is not a valid Map<String, dynamic>.");
      }
    } catch (e, stack) {
      debugPrint("Error in listen(): $e");
      debugPrint(stack.toString());
    }
  }


}
