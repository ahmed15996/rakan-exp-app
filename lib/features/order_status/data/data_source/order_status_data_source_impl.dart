import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:rakaan/core/helpers/enums.dart';

import '../../../../../core/api/api_consumer.dart';
import '../../../../../core/api/base_response.dart';
import '../../../../../core/constants/api_constants.dart';
import '../../../../../core/errors/exceptions.dart';
import '../../../home/data/models/trip_model.dart';
import '../param/order_status_param.dart';
import 'order_status_data_source.dart';

@Injectable(as: OrderStatusDataSource)
class OrderStatusDataSourceImpl extends OrderStatusDataSource {
  final ApiConsumer apiConsumer;

  OrderStatusDataSourceImpl({required this.apiConsumer});

  @override
  Future<TripModel> changeStatus({required OrderStatusParam param}) async {
    BaseResponse response = await apiConsumer.post(
        param.statusType == StatusType.accept
            ? ApiConstants.accept
            : param.statusType == StatusType.receive
                ? ApiConstants.receive
                : ApiConstants.deliver,
        body: {"order_id": param.id});
    if (response.status == true) {
      return TripModel.fromJson(response.data);
    } else {
      throw ServerException(response.message.toString());
    }
  }

  @override
  Future<TripModel> uploadImg({required OrderStatusParam param}) async {
    BaseResponse response = await apiConsumer.post(ApiConstants.updateImg, body: {
      "order_id": param.id,
      if (param.acceptImg!=null) "restaurant_img": MultipartFile.fromFileSync(param.acceptImg!),
      if (param.receiveImg!=null) "delivered_img": MultipartFile.fromFileSync(param.receiveImg!),
      if (param.deliverImg!=null) "completed_img": MultipartFile.fromFileSync(param.deliverImg!),
    },formDataIsEnabled: true);
    if (response.status == true) {
      return TripModel.fromJson(response.data);
    } else {
      throw ServerException(response.message.toString());
    }
  }
}
