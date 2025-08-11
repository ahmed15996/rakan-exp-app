import 'package:bloc/bloc.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/widgets.dart';
import 'package:injectable/injectable.dart';
import 'package:rakaan/core/helpers/custom_pin_code_controller.dart';
import 'package:rakaan/core/util/extensions/navigation.dart';
import 'package:rakaan/core/util/routing/routes.dart';
import 'package:rakaan/core/widgets/custom_toast.dart';

import '../../../data/params/confirm_code_param.dart';
import '../../../data/params/resend_code_param.dart';
import '../../../data/repository/auth_repository.dart';

part 'pin_code_state.dart';

@injectable
class PinCodeCubit extends Cubit<PinCodeState> {
  final AuthRepository authRepository;

  PinCodeCubit({
    required this.authRepository,
  }) : super(PinCodeInitial());

  String formatPhoneNumberWithLocale({
    required String phone,
    required BuildContext context,
  }) {
    late String formattedNumber;

    if (context.locale.languageCode == "ar") {
      formattedNumber = '\u200E${phone.replaceFirst('+', '+')}';
    } else {
      formattedNumber = phone.replaceFirst('+', '+');
    }

    return formattedNumber;
  }

  PinCodeController pinCodeController = PinCodeController();

  void confirmCode({
    required BuildContext context,
    required String countryCode,
    required String phoneNumber,
  }) async {

    emit(PinCodeLoading());

    var result = await authRepository.confirmCode(
      param: ConfirmCodeParam(
        phone: phoneNumber,
        otp: pinCodeController.controller.text,
      ),
    );
    result.fold(
      (failure) {
        showToast(text: failure.message, state: ToastStates.error);
        emit(PinCodeFailure());
      },
      (authModel) => saveDataUser(
        context: context,

        token: authModel.token!,
        img: authModel.user?.img,
        licenseImg: authModel.user?.licenceImg,
        formImg: authModel.user?.formImg,
        carImg: authModel.user?.carImg,
        isNotify: authModel.user?.isNotify,
        name: authModel.user?.name,
        location: authModel.user?.location,
        phone: authModel.user?.phone,
        cityId: authModel.user?.city.id.toString(),
        cityName: authModel.user?.city.name,
        id: authModel.user?.id.toString()??"" ,
        carId:authModel.user?.city.id.toString() ,
        carName:authModel.user?.car.name.toString() ,
        email:authModel.user?.email ,

        countryCode: countryCode,
        phoneNumber: phoneNumber,
      ),
    );
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
        emit(PinCodeFailure());
      },
      (r) {
        context.pushAndRemoveUntilWithNamed(Routes.homeView);

        emit(PinCodeSuccess());
      },
    );
  }

  void resendCode({
    required String countryCode,
    required String phoneNumber,
    required VoidCallback timer,
  }) async {
    emit(ResendCodeLoading());
    var result = await authRepository.resendCode(
      param: ResendCodeParam(
        phone: phoneNumber,
      ),
    );
    result.fold(
      (failure) {
        showToast(text: failure.message, state: ToastStates.error);
        emit(ResendCodeFailure());
      },
      (message) {
        timer();
        emit(ResendCodeSuccess());
      },
    );
  }

  @override
  Future<void> close() {
    pinCodeController.dispose();
    return super.close();
  }
}
