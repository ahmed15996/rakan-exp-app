import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';

import '../../../../../../core/errors/exceptions.dart';
import '../../../../../../core/errors/failures.dart';
import '../../../home/data/models/trip_model.dart';
import '../data_source/orders_data_source.dart';
import '../param/orders_param.dart';
import 'orders_repository.dart';

@Injectable(as: OrdersRepository)
class OrdersRepositoryImpl extends OrdersRepository {
  final OrdersDataSource ordersDataSource;

  OrdersRepositoryImpl({required this.ordersDataSource});

  @override
  Future<Either<Failure, List<TripModel>>> getData({required OrdersParam param}) async {
    try {
      List<TripModel> data = await ordersDataSource.getData(param: param);
      return Right(data);
    } on ServerException catch (exception) {
      return Left(ApiFailure(exception.message!));
    } catch (error) {
      return Left(Failure(error.toString()));
    }
  }
}
