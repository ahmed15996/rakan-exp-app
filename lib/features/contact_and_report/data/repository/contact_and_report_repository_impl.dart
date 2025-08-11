import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';

import '../../../../../core/errors/exceptions.dart';
import '../../../../core/errors/failures.dart';
import '../data_source/contact_and_report_data_source.dart';
import '../params/contact_and_report_param.dart';
import 'contact_and_report_repository.dart';

@Injectable(as: ContactAndReportRepository)
class ContactAndReportRepositoryImpl extends ContactAndReportRepository {
  final ContactAndReportDataSource remoteDataSource;

  ContactAndReportRepositoryImpl({
    required this.remoteDataSource,
  });

  @override
  Future<Either<Failure, String>> addContactAndReport({required ContactAndReportParam param}) async {
    try {
      String msg = await remoteDataSource.addContactAndReport(param: param);
      return Right(msg);
    } on ServerException catch (exception) {
      return Left(ApiFailure(exception.message!));
    } catch (error) {
      return Left(Failure(error.toString()));
    }
  }
}
