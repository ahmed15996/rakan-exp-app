import 'package:dartz/dartz.dart';
import 'package:rakaan/features/home/data/models/trip_model.dart';

import '../../../../core/errors/failures.dart';
import '../param/order_status_param.dart';

abstract class OrderStatusRepository {
  Future<Either<Failure, TripModel>> changeStatus({required OrderStatusParam param});
  Future<Either<Failure, TripModel>> uploadImg({required OrderStatusParam param});

}
