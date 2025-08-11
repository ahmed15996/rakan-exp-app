import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';

import '../../../../../../core/errors/exceptions.dart';
import '../../../../../../core/errors/failures.dart';
import '../data_source/static_page_data_source.dart';
import 'static_page_repository.dart';

@Injectable(as: StaticPageRepository)
class StaticPageRepositoryImpl extends StaticPageRepository {
  final StaticPageDataSource staticPageDataSource;

  StaticPageRepositoryImpl({required this.staticPageDataSource});


  @override
  Future<Either<Failure, String>> getData({required  bool forAbout}) async {
    try {
      String data = await staticPageDataSource.getData(forAbout: forAbout);
      return Right(data);
    } on ServerException catch (exception) {
      return Left(ApiFailure(exception.message!));
    } catch (error) {
      return Left(Failure(error.toString()));
    }
  }
}
