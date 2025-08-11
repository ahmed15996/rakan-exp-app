import 'package:dartz/dartz.dart';

import '../../../../core/errors/failures.dart';
import '../models/home_model.dart';
import '../param/location_param.dart';
import '../param/online_param.dart';

abstract class HomeRepository {
  Future<Either<Failure, HomeModel>> getTrip();

  Future<Either<Failure, String>> updateLocation({required LocationParam param});
  Future<Either<Failure, String>> updateOnline({required OnlineParam param});
}
