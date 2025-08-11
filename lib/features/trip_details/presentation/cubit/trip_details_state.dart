part of 'trip_details_cubit.dart';

@immutable
abstract class TripDetailsState {}

class TripDetailsInitial extends TripDetailsState {}
class TripDetailsUpdate extends TripDetailsState {}

class CurrentLocationLoading extends TripDetailsState {}

class CurrentLocationSuccess extends TripDetailsState {}

class CurrentLocationFailed extends TripDetailsState {
  final String msg;

  CurrentLocationFailed({required this.msg}) {
    showToast(text: msg, state: ToastStates.error);
  }
}


/// get current trip
class TripDetailsLoading extends TripDetailsState {}

class TripDetailsSuccess extends TripDetailsState {}

class TripDetailsFailed extends TripDetailsState {
  final String msg;

  TripDetailsFailed({required this.msg}) {
    showToast(text: msg, state: ToastStates.error);
  }
}


