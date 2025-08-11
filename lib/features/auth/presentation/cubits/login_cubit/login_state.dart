part of 'login_cubit.dart';

@immutable
abstract class LoginState {}

class LoginInitial extends LoginState {}

class ChangeCountryCode extends LoginState {}

class ValidatePhoneNumber extends LoginState {}
class LoginValidationFailed extends LoginState {}

class LoginLoading extends LoginState {}

class LoginSuccess extends LoginState {}

class LoginFailure extends LoginState {}
