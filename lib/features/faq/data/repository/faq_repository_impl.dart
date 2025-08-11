import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import '../models/faq_model.dart';

import '../../../../../../core/errors/exceptions.dart';
import '../../../../../../core/errors/failures.dart';
import '../data_source/faq_data_source.dart';
import 'faq_repository.dart';

@Injectable(as: FaqRepository)
class FaqRepositoryImpl extends FaqRepository {
  final FaqDataSource faqDataSource;

  FaqRepositoryImpl({required this.faqDataSource});

  @override
  Future<Either<Failure, List<FaqModel>>> getData() async {
    try {
      List<FaqModel> data = await faqDataSource.getData();
      return Right(data);
    } on ServerException catch (exception) {
      return Left(ApiFailure(exception.message!));
    } catch (error) {
      return Left(Failure(error.toString()));
    }
  }
}
