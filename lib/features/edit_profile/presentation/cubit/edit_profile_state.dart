part of 'edit_profile_cubit.dart';

@immutable
abstract class EditProfileState {}

class EditProfileInitial extends EditProfileState {}

class ChangeCountryCode extends EditProfileState {}

class ValidatePhoneNumber extends EditProfileState {}

class EditProfileUpdate extends EditProfileState {}

class EditProfileLoading extends EditProfileState {}

class EditProfileSuccess extends EditProfileState {
  final String msg;

  EditProfileSuccess({required this.msg}) {
    showToast(text: msg, state: ToastStates.success);
  }
}

class EditProfileFailed extends EditProfileState {
  final String msg;

  EditProfileFailed({required this.msg}) {
    showToast(text: msg, state: ToastStates.error);
  }
}

class GetDataLoading extends EditProfileState {}

class GetDataFailure extends EditProfileState {
  final String msg;

  GetDataFailure({required this.msg}) {
    showToast(text: msg, state: ToastStates.error);
  }
}

class GetDataSuccess extends EditProfileState {}




