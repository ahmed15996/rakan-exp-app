part of 'side_menu_cubit.dart';

@immutable
abstract class SideMenuState {}

class SideMenuInitial extends SideMenuState {}

class SideMenuUpdate extends SideMenuState {}

class UserDataLoading extends SideMenuState {}

class UserDataSuccess extends SideMenuState {}

class UserDataFailed extends SideMenuState {
  final String msg;

  UserDataFailed({required this.msg});
}

class LogoutLoading extends SideMenuState {}

class LogoutSuccess extends SideMenuState {
  final String msg;

  LogoutSuccess({required this.msg}) {
    showToast(text: msg, state: ToastStates.success);
  }
}

class LogoutFailed extends SideMenuState {
  final String msg;

  LogoutFailed({required this.msg}) {
    showToast(text: msg, state: ToastStates.error);
  }
}
class DeleteAccountLoading extends SideMenuState {}

class DeleteAccountSuccess extends SideMenuState {
  final String msg;

  DeleteAccountSuccess({required this.msg}) {
    showToast(text: msg, state: ToastStates.success);
  }
}

class DeleteAccountFailed extends SideMenuState {
  final String msg;

  DeleteAccountFailed({required this.msg}) {
    showToast(text: msg, state: ToastStates.error);
  }
}

