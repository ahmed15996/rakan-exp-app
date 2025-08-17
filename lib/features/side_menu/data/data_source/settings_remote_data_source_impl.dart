import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:rakaan/features/side_menu/data/data_source/settings_remote_data_source.dart';

import '../../../../../../core/api/api_consumer.dart';
import '../../../../../../core/api/base_response.dart';
import '../../../../../../core/constants/api_constants.dart';
import '../../../../../../core/errors/exceptions.dart';
import '../../../auth/data/models/auth_model.dart';
import '../../../auth/data/models/auth_response.dart';
import '../../../auth/data/params/register_param.dart';

@Injectable(as: SettingsRemoteDataSource)
class SettingsRemoteDataSourceImpl extends SettingsRemoteDataSource {
  final ApiConsumer apiConsumer;

  SettingsRemoteDataSourceImpl({required this.apiConsumer});

  @override
  Future<String> toggleNotification() async {
    BaseResponse response = await apiConsumer.get(
      ApiConstants.toggleNotification,
    );
    if (response.status == true) {
      return response.message;
    } else {
      throw ServerException(response.message.toString());
    }
  }

  @override
  Future<String> logout() async {
    BaseResponse response = await apiConsumer.post(ApiConstants.logout);
    if (response.status == true) {
      return response.message.toString();
    } else {
      throw ServerException(response.message.toString());
    }
  }

  @override
  Future<String> deleteAccount() async {
    BaseResponse response = await apiConsumer.get(ApiConstants.deleteAccount);
    if (response.status == true) {
      return response.message.toString();
    } else {
      throw ServerException(response.message.toString());
    }
  }

  @override
  Future<AuthResponse> editProfile({required RegisterParam param}) async {
    Map<String, dynamic> body = {
      if (param.name != null) "name": param.name,
      if (param.email != null) "email": param.email,
      if (param.cityId != null) "city_id": param.cityId,
      if (param.img != null) "img": MultipartFile.fromFileSync(param.img!),
      if (param.deviceKey != null) "device_key": param.deviceKey,
       "car_id": param.carId,
      if (param.licenceImg != null) "licence_img": MultipartFile.fromFileSync(param.licenceImg!),
      if (param.formImg != null) "form_img": MultipartFile.fromFileSync(param.formImg!),
      if (param.carImg != null) "car_img": MultipartFile.fromFileSync(param.carImg!)
    };
    BaseResponse response = await apiConsumer.post(
      ApiConstants.editProfile,
      body: body,
      formDataIsEnabled: true,
    );
    if (response.status) {
      return AuthResponse(authModel: AuthModel.fromJson(response.data), message: response.message);
    } else {
      throw ServerException(response.message.toString());
    }
  }
}
