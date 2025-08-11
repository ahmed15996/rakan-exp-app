import 'package:dartz/dartz.dart';

import '../../../../core/errors/failures.dart';
import '../models/notification_model.dart';

abstract class NotificationsRepository {
  Future<Either<Failure, List<NotificationModel>>> fetchAllNotifications();

  Future<Either<Failure, String>> deleteAllNotify();
}
