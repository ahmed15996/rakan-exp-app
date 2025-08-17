import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:injectable/injectable.dart';

import '../../../../core/constants/app_colors.dart';
import '../../../../core/helpers/custom_location_helper.dart';
import '../../../../core/widgets/custom_toast.dart';
import '../../../home/data/models/trip_model.dart';
import '../../data/repository/trip_details_repository.dart';

part 'trip_details_state.dart';

@injectable
class TripDetailsCubit extends Cubit<TripDetailsState> {
  TripDetailsCubit(this.repository) : super(TripDetailsInitial());

  final TripDetailsRepository repository;
  LatLng? currentLocation;
  Set<Polyline> polyLines = {};
  List<LatLng> polylineCoordinates = [];
  LatLng defaultLocation = const LatLng(21.437273, 40.512714);
  Completer<GoogleMapController> mapController = Completer<GoogleMapController>();
  GoogleMapController? googleMapController;
  final currentLocationNameCtrl = TextEditingController();
  final Set<Marker> markers = {};

  TripModel? model;

  double heightSheet = .9;

  updateHeight() {
    heightSheet = .32;
    emit(TripDetailsUpdate());
  }

  /// get current trip
  void getTrip({required String id}) async {
    emit(TripDetailsLoading());
    var result = await repository.getTrip(id: id);
    result.fold((failure) {
      emit(TripDetailsFailed(msg: failure.message));
    }, (data) {
      model = data;
if(model?.clint?.lng!=null&&model?.clint?.lat!=null){
  getPolylinePoints();
}
      emit(TripDetailsSuccess());
    });
  }

  void onMapCreate(GoogleMapController controller) async {
    if (!mapController.isCompleted) {
      mapController.complete(controller);
      googleMapController = await mapController.future;
      emit(TripDetailsUpdate());
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
  }

  void onUpdateCamera({required CameraPosition position}) async {
    currentLocation = position.target;
  }

  /// update polyLines
  Future<void> getPolylinePoints() async {
    if (model?.clint == null || model?.serviceProvider == null) return;

    PolylinePoints polylinePoints = PolylinePoints();

    double startLat = double.tryParse(model?.serviceProvider?.lat.toString() ?? "0")!; // Use current location
    double startLng = double.tryParse(model?.serviceProvider?.lng.toString() ?? "0")!;
    double endLat = double.tryParse(model?.clint?.lat.toString() ?? "0")!;
    double endLng = double.tryParse(model?.clint?.lng.toString()?? "0")!;

    LatLng startPoint = LatLng(startLat, startLng);
    LatLng endPoint = LatLng(endLat, endLng);

    PolylineResult result = await polylinePoints.getRouteBetweenCoordinates(
      googleApiKey: "AIzaSyCEMrdoAk7UaoEFCKbIEDtnZAGTsty_Jn4",
      request: PolylineRequest(
        origin: PointLatLng(startLat, startLng),
        destination: PointLatLng(endLat, endLng),
        mode: TravelMode.driving,
      ),
    );
    googleMapController!.animateCamera(CameraUpdate.newCameraPosition(CameraPosition(target: LatLng(startLat, startLng), zoom: 13)));

    polylineCoordinates.clear();
    polyLines.clear();
    markers.clear();

    if (result.points.isNotEmpty) {
      polylineCoordinates = result.points.map((point) => LatLng(point.latitude, point.longitude)).toList();

      polyLines.add(
        Polyline(
          polylineId: const PolylineId("route"),
          points: polylineCoordinates,
          color: AppColors.primaryColor,
          width: 3,
        ),
      );
    }



    emit(TripDetailsUpdate());
  }

  update() {
    emit(TripDetailsUpdate());
  }
}
