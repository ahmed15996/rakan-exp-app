part of 'orders_cubit.dart';

@immutable
abstract class OrdersState {}

class OrdersInitial extends OrdersState {}

class OrdersUpdate extends OrdersState {}

class OrdersLoading extends OrdersState {}

class OrdersSuccess extends OrdersState {}

class OrdersFailed extends OrdersState {
  final String msg;

  OrdersFailed({required this.msg});
}
