import 'package:dartz/dartz.dart';
import '../models/faq_model.dart';

import '../../../../../../core/errors/failures.dart';



abstract class FaqRepository {
  Future<Either<Failure, List<FaqModel>>> getData();
}
