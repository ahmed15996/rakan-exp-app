import 'package:dartz/dartz.dart';
import 'package:rakaan/features/home/data/models/trip_model.dart';

import '../../../../core/errors/failures.dart';

abstract class TripDetailsRepository {
  Future<Either<Failure, TripModel>> getTrip({required String id});

}
