import 'package:dartz/dartz.dart';

import '../../../../../../core/errors/failures.dart';



abstract class StaticPageRepository {
  Future<Either<Failure, String>> getData({required  bool forAbout});
}
