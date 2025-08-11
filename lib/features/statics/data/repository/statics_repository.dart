import 'package:dartz/dartz.dart';
import '../models/static_model.dart';

import '../../../../../../core/errors/failures.dart';



abstract class StaticsRepository {
  Future<Either<Failure, StaticValueModel>> getData();
}
