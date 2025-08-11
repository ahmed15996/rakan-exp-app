import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';

import '../../../../../../core/errors/exceptions.dart';
import '../../../../../../core/errors/failures.dart';
import '../data_source/learn_data_source.dart';
import 'learn_repository.dart';

@Injectable(as: LearnRepository)
class LearnRepositoryImpl extends LearnRepository {
  final LearnDataSource learnDataSource;

  LearnRepositoryImpl({required this.learnDataSource});


  @override
  Future<Either<Failure, String>> getData() async {
    try {
      String data = await learnDataSource.getData();
      return Right(data);
    } on ServerException catch (exception) {
      return Left(ApiFailure(exception.message!));
    } catch (error) {
      return Left(Failure(error.toString()));
    }
  }
}
