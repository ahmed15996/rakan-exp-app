part of 'pin_code_cubit.dart';

@immutable
abstract class PinCodeState {}

class PinCodeInitial extends PinCodeState {}

class PinCodeLoading extends PinCodeState {}

class PinCodeSuccess extends PinCodeState {}

class PinCodeFailure extends PinCodeState {}

class ResendCodeLoading extends PinCodeState {}

class ResendCodeSuccess extends PinCodeState {}

class ResendCodeFailure extends PinCodeState {}
