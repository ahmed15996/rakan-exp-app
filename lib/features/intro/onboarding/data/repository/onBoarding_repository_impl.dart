import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';

import '../../../../../../core/errors/exceptions.dart';
import '../../../../../../core/errors/failures.dart';
import '../data_source/onBoarding_data_source.dart';
import '../models/on_boarding_model.dart';
import 'onBoarding_repository.dart';

@Injectable(as: OnBoardingRepository)
class OnBoardingRepositoryImpl extends OnBoardingRepository {
  final OnBoardingDataSource onBoardingDataSource;

  OnBoardingRepositoryImpl({required this.onBoardingDataSource});


  @override
  Future<Either<Failure, List<OnBoardingModel>>> getData() async {
    try {
      List<OnBoardingModel> data = await onBoardingDataSource.getData();
      return Right(data);
    } on ServerException catch (exception) {
      return Left(ApiFailure(exception.message!));
    } catch (error) {
      return Left(Failure(error.toString()));
    }
  }
}
