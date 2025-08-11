part of 'wallet_cubit.dart';

@immutable
abstract class WalletState {}

class WalletInitial extends WalletState {}
class WalletUpdate extends WalletState {}
class WalletLoading extends WalletState {}

class WalletSuccess extends WalletState {}

class WalletFailed extends WalletState {
  final String msg;

  WalletFailed({required this.msg});
}

class WalletChargingLoading extends WalletState {}

class WalletChargingSuccess extends WalletState {

}

class WalletChargingFailed extends WalletState {
  final String msg;

  WalletChargingFailed({required this.msg}) {
    {
      showToast(text: msg, state: ToastStates.error);
    }
  }
}
