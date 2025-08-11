import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';

import '../../../../../../core/errors/exceptions.dart';
import '../../../../../../core/errors/failures.dart';
import '../data_source/statics_data_source.dart';
import '../models/static_model.dart';
import 'statics_repository.dart';

@Injectable(as: StaticsRepository)
class StaticsRepositoryImpl extends StaticsRepository {
  final StaticsDataSource staticsDataSource;

  StaticsRepositoryImpl({required this.staticsDataSource});

  @override
  Future<Either<Failure, StaticValueModel>> getData() async {
    try {
      StaticValueModel data = await staticsDataSource.getData();
      return Right(data);
    } on ServerException catch (exception) {
      return Left(ApiFailure(exception.message!));
    } catch (error) {
      return Left(Failure(error.toString()));
    }
  }
}
