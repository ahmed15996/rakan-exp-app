import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:rakaan/core/api/api_consumer.dart';
import 'package:rakaan/core/api/base_response.dart';
import 'package:rakaan/core/constants/api_constants.dart';
import 'package:rakaan/core/errors/exceptions.dart';
import 'package:rakaan/core/models/static_model.dart';

import '../../models/auth_model.dart';
import '../../models/auth_response.dart';
import '../../params/confirm_code_param.dart';
import '../../params/login_param.dart';
import '../../params/register_param.dart';
import '../../params/resend_code_param.dart';
import '../../params/verify_user_param.dart';
import 'auth_remote_data_source.dart';

@Injectable(as: AuthRemoteDataSource)
class AuthRemoteDataSourceImpl extends AuthRemoteDataSource {
  final ApiConsumer apiConsumer;

  AuthRemoteDataSourceImpl({required this.apiConsumer});

  @override
  Future<AuthResponse> login({required LoginParam param}) async {
    BaseResponse response = await apiConsumer.post(
      ApiConstants.login,
      body: param.toJson(),
    );
    if (response.status == true) {
      return AuthResponse(authModel: AuthModel.fromJson(response.data), message: response.message);
    } else {
      throw ServerException(response.message.toString());
    }
  }

  @override
  Future<String> register({required RegisterParam param}) async {
    BaseResponse response = await apiConsumer.post(
      ApiConstants.register,
      formDataIsEnabled: true,
      body: {
        "name": param.name,
        "phone": param.phone,
        "email": param.email,
        "id_number": param.idNumber,
        "city_id": param.cityId,
        "date_birth": param.dateBirth,
        "device_key": param.deviceKey,
        "car_id": param.carId,
        "licence_img": MultipartFile.fromFileSync(param.licenceImg!),
        "form_img": MultipartFile.fromFileSync(param.formImg!),
        "car_img": MultipartFile.fromFileSync(param.carImg!)
      },
    );
    if (response.status == true) {
      return response.message;
    } else {
      throw ServerException(response.message.toString());
    }
  }

  @override
  Future<AuthModel> confirmCode({required ConfirmCodeParam param}) async {
    BaseResponse response = await apiConsumer.post(
      ApiConstants.confirmCode,
      body: param.toJson(),
    );
    if (response.status == true) {
      return AuthModel.fromJson(response.data);
    } else {
      throw ServerException(response.message.toString());
    }
  }

  @override
  Future<String> resendCode({required ResendCodeParam param}) async {
    BaseResponse response = await apiConsumer.post(
      ApiConstants.resendCode,
      body: param.toJson(),
    );
    if (response.status == true) {
      return response.message.toString();
    } else {
      throw ServerException(response.message.toString());
    }
  }

  @override
  Future<AuthModel> verifyUser({required VerifyUserParam param}) async {
    List<MultipartFile> documents = [];
    for (var element in param.documents) {
      documents.add(MultipartFile.fromFileSync(element.path));
    }
    Map<String, dynamic> body = {
      'CountryCode': param.countryCode,
      'PhoneNumber': param.phoneNumber,
      'AccountType': param.accountType,
      'Documents': documents,
      if (param.absherMobileNumber != null) 'AbsherMobileNumber': param.absherMobileNumber,
      if (param.titleDeedNumber != null) 'TitleDeedNumber': param.titleDeedNumber,
      if (param.idNumber != null) 'IDNumber': param.idNumber,
      if (param.valLicenseNumber != null) 'ValLicenseNumber': param.valLicenseNumber,
    };
    BaseResponse response = await apiConsumer.post(
      ApiConstants.verifyUser,
      body: body,
      formDataIsEnabled: true,
    );
    if (response.status == true) {
      return AuthModel.fromJson(response.data);
    } else {
      throw ServerException(response.message.toString());
    }
  }
  @override
  Future<List<StaticModel>> getCars() async {
    BaseResponse response = await apiConsumer.get(
      ApiConstants.getCars,
    );
    if (response.status == true) {
      return List.from(response.data).map((e) => StaticModel.fromJson(e)).toList();
    } else {
      throw ServerException(response.message.toString());
    }
  }
  @override
  Future<List<StaticModel>> getCities() async {
    BaseResponse response = await apiConsumer.get(
      ApiConstants.getCities,
    );
    if (response.status == true) {
      return List.from(response.data).map((e) => StaticModel.fromJson(e)).toList();
    } else {
      throw ServerException(response.message.toString());
    }
  }
}
