import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';

import '../../../../core/errors/exceptions.dart';
import '../../../../core/errors/failures.dart';
import '../data_source/remote/notifications_remote_data_source.dart';
import '../models/notification_model.dart';
import 'notifications_repository.dart';

@Injectable(as: NotificationsRepository)
class NotificationsRepositoryImpl extends NotificationsRepository {
  final NotificationsRemoteDataSource notificationsRemoteDataSource;

  NotificationsRepositoryImpl({required this.notificationsRemoteDataSource});

  @override
  Future<Either<Failure, String>> deleteAllNotify() async {
    try {
      String message = await notificationsRemoteDataSource.deleteAllNotify();
      return Right(message);
    } on ServerException catch (exception) {
      return Left(ApiFailure(exception.message!));
    } catch (error) {
      return Left(Failure(error.toString()));
    }
  }

  @override
  Future<Either<Failure, List<NotificationModel>>> fetchAllNotifications() async {
    try {
      List<NotificationModel> model = await notificationsRemoteDataSource.fetchAllNotifications();
      return Right(model);
    } on ServerException catch (exception) {
      return Left(ApiFailure(exception.message!));
    } catch (error) {
      return Left(Failure(error.toString()));
    }
  }


}
