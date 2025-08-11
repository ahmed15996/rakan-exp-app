import 'package:injectable/injectable.dart';
import 'package:rakaan/features/home/data/models/trip_model.dart';

import '../../../../../../core/api/api_consumer.dart';
import '../../../../../../core/api/base_response.dart';
import '../../../../../../core/constants/api_constants.dart';
import '../../../../../../core/errors/exceptions.dart';
import '../../../../core/models/general_model.dart';
import '../models/order_model.dart';
import '../param/orders_param.dart';
import 'orders_data_source.dart';

@Injectable(as: OrdersDataSource)
class OrdersDataSourceImpl extends OrdersDataSource {
  final ApiConsumer apiConsumer;

  OrdersDataSourceImpl({required this.apiConsumer});

  @override
  Future<List<TripModel>> getData({required OrdersParam param}) async {
    BaseResponse response = await apiConsumer.post(
      ApiConstants.orders,
      body: {
       if(param.typeOrder!=null) "type_order":param.typeOrder,
        if(param.type!=null) "type":param.type,
      }
    );
    if (response.status) {
      return List.from(response.data).map((e) => TripModel.fromJson(e)).toList();
    } else {
      throw ServerException(response.message.toString());
    }
  }
}
