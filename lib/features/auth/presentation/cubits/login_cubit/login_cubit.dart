import 'package:bloc/bloc.dart';
import 'package:country_code_picker/country_code_picker.dart';
import 'package:country_code_picker_plus/country_code_picker_plus.dart';
import 'package:flutter/widgets.dart';
import 'package:injectable/injectable.dart';
import 'package:rakaan/core/local/shared_preferences/shared_pref_services.dart';
import 'package:rakaan/core/util/extensions/navigation.dart';
import 'package:rakaan/core/util/routing/routes.dart';
import 'package:rakaan/core/widgets/custom_toast.dart';

import '../../../../../core/framework/app_firebase.dart';
import '../../../data/arguments/pin_code_argument.dart';
import '../../../data/models/auth_response.dart';
import '../../../data/params/login_param.dart';
import '../../../data/repository/auth_repository.dart';

part 'login_state.dart';

@injectable
class LoginCubit extends Cubit<LoginState> {
  final AuthRepository repository;
  final SharedPrefServices sharedPrefServices;

  LoginCubit({required this.repository, required this.sharedPrefServices}) : super(LoginInitial());

  final formKey = GlobalKey<FormState>();
  final phoneCtrl = TextEditingController();

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

  void login({required BuildContext context}) async {
    emit(LoginLoading());
    String fcmToken = await AppFirebase().getFirebaseToken() ?? "fcm token";
    var result = await repository.login(
      param: LoginParam(phone: phoneCtrl.text, deviceToken: fcmToken),
    );
    result.fold(
      (failure) {
        showToast(text: failure.message, state: ToastStates.error);
        emit(LoginFailure());
      },
      (authModel) {
        if (authModel.authModel?.isBending ?? false) {
          showToast(
            text: authModel.message ?? "",
            state: ToastStates.success,
          );

          context.pushWithNamed(
            Routes.pinCodeView,
            arguments: PinCodeArgument(
              countryCode: countryCode.dialCode!,
              phoneNumber: phoneCtrl.text,
            ),
          );
          emit(LoginSuccess());
        } else {
          showToast(
            text: authModel.message ?? "",
            state: ToastStates.success,
          );

          emit(LoginSuccess());
        }
      },
    );
  }

  void saveDataUser({
    required AuthResponse authModel,
    required BuildContext context,
  }) async {
    var result = await repository.saveUserData(
      img: authModel.authModel?.user?.img,
      location: authModel.authModel?.user?.location,
      isNotify: authModel.authModel?.user?.isNotify,
      name: authModel.authModel?.user?.name,
      phone: authModel.authModel?.user?.phone,
      cityName: authModel.authModel?.user?.city.name,
      cityId: authModel.authModel?.user?.city.id.toString(),
      token: authModel.authModel!.token!,
      id: authModel.authModel?.user?.id.toString() ?? "",
    );
    result.fold(
      (failure) {
        showToast(text: failure.message, state: ToastStates.error);
        emit(LoginFailure());
      },
      (r) {
        showToast(
          text: authModel.message ?? "",
          state: ToastStates.success,
        );

        context.pushAndRemoveUntilWithNamed(Routes.homeView);

        emit(LoginSuccess());
      },
    );
  }

  @override
  Future<void> close() {
    phoneCtrl.dispose();

    return super.close();
  }
}
