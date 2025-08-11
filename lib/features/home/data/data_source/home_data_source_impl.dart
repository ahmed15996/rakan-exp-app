import 'package:injectable/injectable.dart';

import '../../../../../core/api/api_consumer.dart';
import '../../../../../core/api/base_response.dart';
import '../../../../../core/constants/api_constants.dart';
import '../../../../../core/errors/exceptions.dart';
import '../models/home_model.dart';
import '../param/location_param.dart';
import '../param/online_param.dart';
import 'home_data_source.dart';

@Injectable(as: HomeDataSource)
class HomeDataSourceImpl extends HomeDataSource {
  final ApiConsumer apiConsumer;

  HomeDataSourceImpl({required this.apiConsumer});

  @override
  Future<HomeModel> getTrip() async {
    BaseResponse response = await apiConsumer.get(
      ApiConstants.home,
    );
    if (response.status == true) {
      return HomeModel.fromJson(response.data);
    } else {
      throw ServerException(response.message.toString());
    }
  }

  @override
  Future<String> updateLocation({required LocationParam param}) async {
    BaseResponse response = await apiConsumer.post(
      ApiConstants.updateLocation,
      body: param.toJson()
    );
    if (response.status == true) {
      return response.message;
    } else {
      throw ServerException(response.message.toString());
    }
  }

  @override
  Future<String> updateOnline({required OnlineParam param}) async {
    BaseResponse response = await apiConsumer.post(ApiConstants.updateOnline, body: param.toJson());
    if (response.status == true) {
      return response.message;
    } else {
      throw ServerException(response.message.toString());
    }
  }
}
