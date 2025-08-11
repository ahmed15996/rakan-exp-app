import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';

import '../../../../core/errors/exceptions.dart';
import '../../../../core/errors/failures.dart';
import '../../../home/data/models/trip_model.dart';
import '../data_source/order_status_data_source.dart';
import '../param/order_status_param.dart';
import 'order_status_repository.dart';

@Injectable(as: OrderStatusRepository)
class OrderStatusRepositoryImpl extends OrderStatusRepository {
  final OrderStatusDataSource orderStatusDataSource;

  OrderStatusRepositoryImpl({required this.orderStatusDataSource});

  @override
  Future<Either<Failure, TripModel>> changeStatus({required OrderStatusParam param}) async {
    try {
      TripModel model = await orderStatusDataSource.changeStatus(param: param);
      return Right(model);
    } on ServerException catch (exception) {
      return Left(ApiFailure(exception.message!));
    } catch (error) {
      return Left(Failure(error.toString()));
    }
  }
  @override
  Future<Either<Failure, TripModel>> uploadImg({required OrderStatusParam param}) async {
    try {
      TripModel model = await orderStatusDataSource.uploadImg(param: param);
      return Right(model);
    } on ServerException catch (exception) {
      return Left(ApiFailure(exception.message!));
    } catch (error) {
      return Left(Failure(error.toString()));
    }
  }
}
