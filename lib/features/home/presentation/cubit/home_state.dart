part of 'home_cubit.dart';

@immutable
abstract class HomeState {}

class HomeInitial extends HomeState {}
class HomeUpdate extends HomeState {}
class SocketUpdateState extends HomeState {}

class CurrentLocationLoading extends HomeState {}

class CurrentLocationSuccess extends HomeState {}

class CurrentLocationFailed extends HomeState {
  final String msg;

  CurrentLocationFailed({required this.msg}) {
    showToast(text: msg, state: ToastStates.error);
  }
}

/// update online
class UpdateOnlineLoading extends HomeState {}

class UpdateOnlineSuccess extends HomeState {
  final String msg;

  UpdateOnlineSuccess({required this.msg});
}

class UpdateOnlineFailed extends HomeState {
  final String msg;

  UpdateOnlineFailed({required this.msg}) {
    showToast(text: msg, state: ToastStates.error);
  }
}

/// update Location

class UpdateLocationLoading extends HomeState {}

class UpdateLocationSuccess extends HomeState {
  final String msg;

  UpdateLocationSuccess({required this.msg}) {
    showToast(text: msg, state: ToastStates.success);
  }
}

class UpdateLocationFailed extends HomeState {
  final String msg;

  UpdateLocationFailed({required this.msg}) {
    showToast(text: msg, state: ToastStates.error);
  }
}

/// get current trip
class GetTripLoading extends HomeState {}

class GetTripSuccess extends HomeState {}

class GetTripFailed extends HomeState {
  final String msg;

  GetTripFailed({required this.msg}) {
    showToast(text: msg, state: ToastStates.error);
  }
}

