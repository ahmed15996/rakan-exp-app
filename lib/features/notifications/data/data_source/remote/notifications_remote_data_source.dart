import '../../models/notification_model.dart';

abstract class NotificationsRemoteDataSource {
  Future<List<NotificationModel>> fetchAllNotifications();
  Future<String> deleteAllNotify();
}
