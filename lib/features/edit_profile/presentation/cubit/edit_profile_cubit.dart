import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:country_code_picker/country_code_picker.dart';
import 'package:country_code_picker_plus/country_code_picker_plus.dart';
import 'package:flutter/widgets.dart';
import 'package:injectable/injectable.dart';
import 'package:rakaan/core/widgets/custom_toast.dart';

import '../../../../core/constants/app_cached.dart';
import '../../../../core/framework/app_firebase.dart';
import '../../../../core/helpers/image_helper.dart';
import '../../../../core/local/shared_preferences/shared_pref_services.dart';
import '../../../../core/models/static_model.dart';
import '../../../auth/data/params/register_param.dart';
import '../../../auth/data/repository/auth_repository.dart';
import '../../../side_menu/data/repository/settings_repository.dart';

part 'edit_profile_state.dart';

@injectable
class EditProfileCubit extends Cubit<EditProfileState> {
  EditProfileCubit(this.repository, this.pref, this.documentHelper, this.authRepository) : super(EditProfileInitial());
  final SettingsRepository repository;
  final AuthRepository authRepository;
  final SharedPrefServices pref;
  final DocumentHelper documentHelper;
  final formKey = GlobalKey<FormState>();
  final nameCtrl = TextEditingController();
  final phoneCtrl = TextEditingController();
  final emailCtrl = TextEditingController();
  final carImg = TextEditingController();
  final formImg = TextEditingController();
  final licenceImg = TextEditingController();

  StaticModel? carModel, cityModel;
  List<StaticModel> cars = [];
  List<StaticModel> cities = [];
  String? image, savedImg;

  selectCarType({required StaticModel model}) {
    carModel = model;
    emit(EditProfileUpdate());
  }

  selectCity({required StaticModel model}) {
    cityModel = model;
    emit(EditProfileUpdate());
  }

  void pickCarImage() async {
    File? file = await documentHelper.pickImage(
      type: PickImageFromEnum.gallery,
      isCompress: true,
    );
    if (file != null) {
      carImg.text = file.path;
      emit(EditProfileUpdate());
    }
  }

  void pickFormImage() async {
    File? file = await documentHelper.pickImage(
      type: PickImageFromEnum.gallery,
      isCompress: true,
    );
    if (file != null) {
      formImg.text = file.path;
      emit(EditProfileUpdate());
    }
  }

  void pickLicenceImage() async {
    File? file = await documentHelper.pickImage(
      type: PickImageFromEnum.gallery,
      isCompress: true,
    );
    if (file != null) {
      licenceImg.text = file.path;
      emit(EditProfileUpdate());
    }
  }

  void pickImage() async {
    File? file = await documentHelper.pickImage(
      type: PickImageFromEnum.gallery,
      isCompress: true,
    );
    if (file != null) {
      image = file.path;

      emit(EditProfileUpdate());
    }
  }

  getSavedData() {
    String? name = pref.getData(key: AppCached.name);
    String? phone = pref.getData(key: AppCached.phone);
    String? email = pref.getData(key: AppCached.email);
    String? userImg = pref.getData(key: AppCached.img) ??null;
    // String? license = pref.getData(key: AppCached.licenseImg);
    // String? form = pref.getData(key: AppCached.formImg);
    // String? car = pref.getData(key: AppCached.carImg);
    if (name != null) {
      nameCtrl.text = name;
    }
    if (phone != null) {
      phoneCtrl.text = phone;
    }
    if (email != null) {
      emailCtrl.text = email;
    }
    if (userImg != null) {
      savedImg = userImg;
    }
    // if (license != null) {
    //   licenceImg.text = license;
    // }
    // if (form != null) {
    //   formImg.text = form;
    // }
    // if (car != null) {
    //   carImg.text = car;
    // }
    if (pref.getData(key: AppCached.cityId) != null) {
      cityModel = StaticModel(
          id: int.tryParse(pref.getData(key: AppCached.cityId).toString()) ?? 0, name: pref.getData(key: AppCached.cityName), img: null);
    }
    if (pref.getData(key: AppCached.carId) != null) {
      carModel = StaticModel(
          id: int.tryParse(pref.getData(key: AppCached.carId).toString()) ?? 0, name: pref.getData(key: AppCached.carName), img: null);
    }

    emit(EditProfileUpdate());
  }

  /// edit profile
  void editProfile({required BuildContext context}) async {
    emit(EditProfileLoading());
    print( carModel?.id.toString());
    print( pref.getData(key: AppCached.carId));
    String fcmToken = await AppFirebase().getFirebaseToken() ?? "";
    var result = await repository.editProfile(
      param: RegisterParam(
          name: nameCtrl.text,
          deviceKey: fcmToken,
          dateBirth: "",
          img: image,
          idNumber: "",
          carId: carModel?.id.toString(),
          phone: phoneCtrl.text,
          cityId: cityModel?.id.toString(),
          email: emailCtrl.text,
          carImg: carImg.text.isNotEmpty ? carImg.text : null,
          formImg: formImg.text.isNotEmpty ? formImg.text : null,
          licenceImg: licenceImg.text.isNotEmpty ? licenceImg.text : null),
    );
    result.fold((failure) {
      print(failure.message);
      emit(EditProfileFailed(msg: failure.message));
    }, (authRepository) async {
      saveDataUser(
        context: context,
        countryCode: countryCode.code.toString(),
        phoneNumber: phoneCtrl.text,
        token: pref.getData(key: AppCached.token),
        img: authRepository.authModel?.user?.img,
        licenseImg: authRepository.authModel?.user?.licenceImg,
        formImg: authRepository.authModel?.user?.formImg,
        carImg: authRepository.authModel?.user?.carImg,
        isNotify: authRepository.authModel?.user?.isNotify,
        name: authRepository.authModel?.user?.name,
        location: authRepository.authModel?.user?.location,
        phone: authRepository.authModel?.user?.phone,
        cityId: authRepository.authModel?.user?.city.id.toString(),
        cityName: authRepository.authModel?.user?.city.name,
        id: authRepository.authModel?.user?.id.toString() ?? "",
        carId: authRepository.authModel?.user?.car.id.toString(),
        carName: authRepository.authModel?.user?.car.name.toString(),
        email: authRepository.authModel?.user?.email,
      );
    });
  }

  // get cars
  void getCars() async {
    emit(GetDataLoading());
    var result = await authRepository.getCars();
    result.fold((failure) {
      emit(GetDataFailure(msg: failure.message));
    }, (data) {
      cars = data;
      getCities();
    });
  }

  // get cities
  void getCities() async {
    var result = await authRepository.getCities();
    result.fold((failure) {
      emit(GetDataFailure(msg: failure.message));
    }, (data) {
      cities = data;
      emit(GetDataSuccess());
    });
  }

  void saveDataUser({
    required String token,
    required String id,
    String? accType,
    String? img,
    bool? isNotify,
    String? name,
    String? phone,
    String? cityId,
    String? cityName,
    String? carId,
    String? carName,
    String? location,
    String? licenseImg,
    String? formImg,
    String? email,
    String? carImg,
    required String countryCode,
    required String phoneNumber,
    required BuildContext context,
  }) async {
    var result = await authRepository.saveUserData(
        token: token,
        id: id,
        accType: accType,
        img: img,
        licenseImg: licenseImg,
        formImg: formImg,
        carImg: carImg,
        carId: carId,
        carName: carName,
        location: location,
        isNotify: isNotify,
        name: name,
        phone: phone,
        email: email,
        cityName: cityName,
        cityId: cityId);
    result.fold(
      (failure) {
        showToast(text: failure.message, state: ToastStates.error);
        emit(EditProfileFailed(msg: failure.message));
      },
      (r) {
        emit(EditProfileSuccess(msg: r));
      },
    );
  }

  /// edit phone
  CountryCode countryCode = CountryCode.fromCountryCode('SA');

  void changeCountryCode(CountryCode value) async {
    if (countryCode != value) {
      countryCode = value;
      await validatePhoneNumber(phoneCtrl.text);
      emit(ChangeCountryCode());
    }
  }

  Future<bool> validatePhoneNumber(String value) async {
    try {
      final isValid = await PhoneService.parsePhoneNumber(
        value,
        countryCode.code!,
      );
      emit(ValidatePhoneNumber());
      return isValid ?? false;
    } catch (e) {
      emit(ValidatePhoneNumber());
      return false;
    }
  }
}
