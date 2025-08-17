import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:country_code_picker/country_code_picker.dart';
import 'package:country_code_picker_plus/country_code_picker_plus.dart';
import 'package:flutter/widgets.dart';
import 'package:injectable/injectable.dart';
import 'package:rakaan/core/models/static_model.dart';
import 'package:rakaan/core/widgets/custom_toast.dart';

import '../../../../../../core/framework/app_firebase.dart';
import '../../../../../../core/helpers/image_helper.dart';
import '../../../data/params/register_param.dart';
import '../../../data/repository/auth_repository.dart';

part 'register_state.dart';

@injectable
class RegisterCubit extends Cubit<RegisterState> {
  final AuthRepository repository;
  final DocumentHelper documentHelper;

  RegisterCubit({required this.repository, required this.documentHelper}) : super(RegisterInitial());
  bool isFirstStep = true;
  final formKey = GlobalKey<FormState>();
  final nameCtrl = TextEditingController();
  final phoneCtrl = TextEditingController();
  final emailCtrl = TextEditingController();
  final idNumCtrl = TextEditingController();
  final birthDay = TextEditingController();
  final carImg = TextEditingController();
  final formImg = TextEditingController();
  final licenceImg = TextEditingController();

  StaticModel? carModel, cityModel;
  List<StaticModel> cars = [];
  List<StaticModel> cities = [];

  CountryCode countryCode = CountryCode.fromCountryCode('SA');

  selectCarType({required StaticModel model}) {
    carModel = model;
    emit(RegisterUpdate());
  }

  selectCity({required StaticModel model}) {
    cityModel = model;
    emit(RegisterUpdate());
  }

  selectStep() {
    isFirstStep = !isFirstStep;
    emit(RegisterUpdate());
  }

  void changeCountryCode(CountryCode value) async {
    if (countryCode != value) {
      countryCode = value;
      await validatePhoneNumber(phoneCtrl.text);
      emit(ChangeCountryCode());
    }
  }

  Future<bool> validatePhoneNumber(String value) async {
    try {
      print("Original value: $value");
      print("Country code: ${countryCode.code}"); // مثل "SA"
      print("Dial code: ${countryCode.dialCode}"); // مثل "+966"

      // 1. تنظيف الرقم من المسافات
      String phone = value.trim().replaceAll(' ', '');

      // 2. إزالة الصفر في البداية إن وُجد
      if (phone.startsWith('0')) {
        phone = phone.substring(1);
      }

      // 3. التأكد من وجود الكود الدولي في البداية
      if (!phone.startsWith('+')) {
        phone = '${countryCode.dialCode}$phone';
      }

      print("Normalized phone: $phone");

      // 4. التحقق باستخدام PhoneService
      final isValid = await PhoneService.parsePhoneNumber(
        phone,
        countryCode.code!,
      );

      print("PhoneService validation: $isValid");

      // 5. إذا تم التحقق بنجاح من PhoneService
      if (isValid == true) {
        emit(ValidatePhoneNumber());
        return true;
      }

      // 6. التحقق اليدوي للبدايات المسموح بها
      final phoneWithoutCode = phone.replaceFirst(countryCode.dialCode!, '');

      bool isKnownSaudiPrefix(String number) {
        return number.startsWith('50') ||
            number.startsWith('53') ||
            number.startsWith('54') ||
            number.startsWith('55') ||
            number.startsWith('56') ||
            number.startsWith('57') ||
            number.startsWith('58') ||
            number.startsWith('59') ||
            number.startsWith('52'); // دعم 052 يدويًا
      }

      final manualValid = countryCode.code == 'SA' && phoneWithoutCode.length == 9 && isKnownSaudiPrefix(phoneWithoutCode);

      print("Manual validation: $manualValid");

      emit(ValidatePhoneNumber());
      return manualValid;
    } catch (e) {
      print("Validation error: $e");
      emit(ValidatePhoneNumber());
      return false;
    }
  }

  void pickCarImage() async {
    File? file = await documentHelper.pickImage(
      type: PickImageFromEnum.gallery,
      isCompress: true,
    );
    if (file != null) {
      carImg.text = file.path;
      emit(RegisterUpdate());
    }
  }

  void pickFormImage() async {
    File? file = await documentHelper.pickImage(
      type: PickImageFromEnum.gallery,
      isCompress: true,
    );
    if (file != null) {
      formImg.text = file.path;
      emit(RegisterUpdate());
    }
  }

  void pickLicenceImage() async {
    File? file = await documentHelper.pickImage(
      type: PickImageFromEnum.gallery,
      isCompress: true,
    );
    if (file != null) {
      licenceImg.text = file.path;
      emit(RegisterUpdate());
    }
  }

  void register({required BuildContext context}) async {
    emit(RegisterLoading());
    String fcmToken = await AppFirebase().getFirebaseToken() ?? "";
    var result = await repository.register(
      param: RegisterParam(
          name: nameCtrl.text,
          deviceKey: fcmToken,
          idNumber: idNumCtrl.text,
          carId: carModel?.id.toString(),
          phone: phoneCtrl.text,
          dateBirth: birthDay.text,
          cityId: cityModel?.id.toString(),
          email: emailCtrl.text,
          carImg: carImg.text,
          formImg: formImg.text,
          licenceImg: licenceImg.text),
    );
    result.fold(
      (failure) {
        showToast(text: failure.message, state: ToastStates.error);
        emit(RegisterFailure());
      },
      (msg) {
        // context.pushReplacementWithNamed(
        //   Routes.pinCodeView,
        //   arguments: PinCodeArgument(
        //     countryCode: countryCode.dialCode!,
        //     phoneNumber: phoneCtrl.text,
        //   ),
        // );

        emit(RegisterSuccess());
      },
    );
  }

  // get cars
  void getCars() async {
    emit(GetDataLoading());
    var result = await repository.getCars();
    result.fold((failure) {
      emit(GetDataFailure(msg: failure.message));
    }, (data) {
      cars = data;
      getCities();
    });
  }

  // get cities
  void getCities() async {
    var result = await repository.getCities();
    result.fold((failure) {
      emit(GetDataFailure(msg: failure.message));
    }, (data) {
      cities = data;
      emit(GetDataSuccess());
    });
  }
}
