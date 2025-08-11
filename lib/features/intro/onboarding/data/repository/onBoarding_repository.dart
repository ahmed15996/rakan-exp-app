import 'package:dartz/dartz.dart';

import '../../../../../../core/errors/failures.dart';
import '../models/on_boarding_model.dart';



abstract class OnBoardingRepository {
  Future<Either<Failure, List<OnBoardingModel>>> getData();
}
