import 'package:injectable/injectable.dart';

import '../../../../../core/api/api_consumer.dart';
import '../../../../../core/api/base_response.dart';
import '../../../../../core/constants/api_constants.dart';
import '../../../../../core/errors/exceptions.dart';
import '../../models/notification_model.dart';
import 'notifications_remote_data_source.dart';

@Injectable(as: NotificationsRemoteDataSource)
class NotificationsRemoteDataSourceImpl extends NotificationsRemoteDataSource {
  final ApiConsumer apiConsumer;

  NotificationsRemoteDataSourceImpl({required this.apiConsumer});

  @override
  Future<String> deleteAllNotify() async {
    BaseResponse response = await apiConsumer.get(
      ApiConstants.deleteNotification,
    );
    if (response.status == true) {
      return response.message.toString();
    } else {
      throw ServerException(response.message.toString());
    }
  }

  @override
  Future<List<NotificationModel>> fetchAllNotifications() async {
    BaseResponse response = await apiConsumer.get(
      ApiConstants.fetchAllNotification,
    );
    if (response.status == true) {
      return List.from(response.data).map((e) => NotificationModel.fromJson(e)).toList();
    } else {
      throw ServerException(response.message.toString());
    }
  }
}
