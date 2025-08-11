import 'package:dartz/dartz.dart';

import '../../../../../../core/errors/failures.dart';



abstract class LearnRepository {
  Future<Either<Failure, String>> getData();
}
