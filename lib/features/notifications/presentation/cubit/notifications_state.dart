part of 'notifications_cubit.dart';

@immutable
abstract class NotificationsState {}

class NotificationsInitial extends NotificationsState {}

class NotificationsLoading extends NotificationsState {}

class NotificationsSuccess extends NotificationsState {}

class NotificationsFailed extends NotificationsState {
  final String msg;

  NotificationsFailed({required this.msg});
}
class DeleteNotificationsLoading extends NotificationsState {}

class DeleteNotificationsSuccess extends NotificationsState {}

class DeleteNotificationsFailed extends NotificationsState {
  final String msg;

  DeleteNotificationsFailed({required this.msg});
}
