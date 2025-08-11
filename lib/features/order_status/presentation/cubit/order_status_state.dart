part of 'order_status_cubit.dart';

@immutable
abstract class OrderStatusState {}

class OrderStatusInitial extends OrderStatusState {}

class OrderStatusUpdate extends OrderStatusState {}

class OrderStatusLoading extends OrderStatusState {}

class OrderStatusSuccess extends OrderStatusState {

}

class OrderStatusFailed extends OrderStatusState {
  final String msg;

  OrderStatusFailed({required this.msg}){
    showToast(text: msg, state: ToastStates.error);
  }
}

class UpdateImgLoading extends OrderStatusState {}

class UpdateImgSuccess extends OrderStatusState {}

class UpdateImgFailed extends OrderStatusState {
  final String msg;

  UpdateImgFailed({required this.msg});
}
