import 'package:bloc/bloc.dart';
import 'package:flutter/widgets.dart';
import 'package:injectable/injectable.dart';
import 'package:rakaan/features/notifications/data/repository/notifications_repository.dart';

import '../../data/models/notification_model.dart';

part 'notifications_state.dart';

@injectable
class NotificationsCubit extends Cubit<NotificationsState> {
  NotificationsCubit(this.repository) : super(NotificationsInitial());

  final NotificationsRepository repository;

  List<NotificationModel> list = [];

  void getData() async {
    emit(NotificationsLoading());
    var result = await repository.fetchAllNotifications();
    result.fold((failure) {
      emit(NotificationsFailed(msg: failure.message));
    }, (data) {
      list = data;
      emit(NotificationsSuccess());
    });
  }

  void deleteData() async {
    emit(DeleteNotificationsLoading());
    var result = await repository.deleteAllNotify();
    result.fold((failure) {
      emit(DeleteNotificationsFailed(msg: failure.message));
    }, (data) {
      list.clear();
      emit(DeleteNotificationsSuccess());
    });
  }
}
