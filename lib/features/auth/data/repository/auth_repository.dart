import 'package:dartz/dartz.dart';
import 'package:rakaan/core/errors/failures.dart';
import 'package:rakaan/core/models/static_model.dart';

import '../models/auth_model.dart';
import '../models/auth_response.dart';
import '../params/confirm_code_param.dart';
import '../params/login_param.dart';
import '../params/register_param.dart';
import '../params/resend_code_param.dart';
import '../params/verify_user_param.dart';

abstract class AuthRepository {
  Future<Either<Failure, AuthResponse>> login({required LoginParam param});

  Future<Either<Failure, String>> register({required RegisterParam param});

  Future<Either<Failure, AuthModel>> confirmCode({required ConfirmCodeParam param});

  Future<Either<Failure, String>> resendCode({required ResendCodeParam param});

  Future<Either<Failure, AuthModel>> verifyUser({required VerifyUserParam param});

  Future<Either<Failure, String>> saveUserData(
      {required String token,
      required String id,
      String? accType,
      String? img,
      bool? isNotify,
      String? name,
      String? phone,
      String? cityId,
      String? cityName,
      String? carId,
      String? carName,
      String? email,
      String? licenseImg,
        String? formImg,
        String? carImg,
      String? location});
  Future<Either<Failure, List<StaticModel>>> getCars();
  Future<Either<Failure, List<StaticModel>>> getCities();
}
