import 'package:dartz/dartz.dart';

import '../../../../../../core/errors/failures.dart';
import '../../../home/data/models/trip_model.dart';
import '../param/orders_param.dart';

abstract class OrdersRepository {
  Future<Either<Failure, List<TripModel>>> getData({required OrdersParam param});
}
