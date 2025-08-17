part of 'register_cubit.dart';

@immutable
abstract class RegisterState {}

class RegisterInitial extends RegisterState {}

class RegisterUpdate extends RegisterState {}

class AcceptTermsSuccess extends RegisterState {}

class RegisterLoading extends RegisterState {}

class RegisterFailure extends RegisterState {}

class RegisterSuccess extends RegisterState {

}

class RegisterValidationFailure extends RegisterState {}

class ChangeCountryCode extends RegisterState {}

class ValidatePhoneNumber extends RegisterState {}

class GetDataLoading extends RegisterState {}

class GetDataFailure extends RegisterState {
  final String msg;

  GetDataFailure({required this.msg}) {
    showToast(text: msg, state: ToastStates.error);
  }
}

class GetDataSuccess extends RegisterState {}
