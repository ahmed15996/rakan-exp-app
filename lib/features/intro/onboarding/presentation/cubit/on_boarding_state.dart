part of 'on_boarding_cubit.dart';

@immutable
abstract class OnBoardingState {}

class OnBoardingInitial extends OnBoardingState {}

class OnBoardingLoading extends OnBoardingState {}

class OnBoardingSuccess extends OnBoardingState {}

class OnBoardingFailed extends OnBoardingState {
  final String msg;

  OnBoardingFailed({required this.msg}) {
    showToast(text: msg, state: ToastStates.error);
  }
}

class OnBoardingUpdateState extends OnBoardingState {}

class OnBoardingCompleteState extends OnBoardingState {}
