import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';

import '../../../../core/errors/exceptions.dart';
import '../../../../core/errors/failures.dart';
import '../data_source/home_data_source.dart';
import '../models/home_model.dart';
import '../param/location_param.dart';
import '../param/online_param.dart';
import 'home_repository.dart';

@Injectable(as: HomeRepository)
class HomeRepositoryImpl extends HomeRepository {
  final HomeDataSource homeDataSource;

  HomeRepositoryImpl({required this.homeDataSource});

  @override
  Future<Either<Failure, HomeModel>> getTrip() async {
    try {
      HomeModel model = await homeDataSource.getTrip();
      return Right(model);
    } on ServerException catch (exception) {
      return Left(ApiFailure(exception.message!));
    } catch (error) {
      return Left(Failure(error.toString()));
    }
  }

  @override
  Future<Either<Failure, String>> updateLocation({required LocationParam param}) async {
    try {
      String model = await homeDataSource.updateLocation(param: param);
      return Right(model);
    } on ServerException catch (exception) {
      return Left(ApiFailure(exception.message!));
    } catch (error) {
      return Left(Failure(error.toString()));
    }
  }
  @override
  Future<Either<Failure, String>> updateOnline({required OnlineParam param}) async {
    try {
      String model = await homeDataSource.updateOnline(param: param);
      return Right(model);
    } on ServerException catch (exception) {
      return Left(ApiFailure(exception.message!));
    } catch (error) {
      return Left(Failure(error.toString()));
    }
  }
}
