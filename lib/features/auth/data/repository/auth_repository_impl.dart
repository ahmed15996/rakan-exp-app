import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:rakaan/core/errors/exceptions.dart';
import 'package:rakaan/core/errors/failures.dart';

import '../../../../core/models/static_model.dart';
import '../data_source/local/auth_local_data_source.dart';
import '../data_source/remote/auth_remote_data_source.dart';
import '../models/auth_model.dart';
import '../models/auth_response.dart';
import '../params/confirm_code_param.dart';
import '../params/login_param.dart';
import '../params/register_param.dart';
import '../params/resend_code_param.dart';
import '../params/verify_user_param.dart';
import 'auth_repository.dart';

@Injectable(as: AuthRepository)
class AuthRepositoryImpl extends AuthRepository {
  final AuthRemoteDataSource authRemoteDataSource;
  final AuthLocalDataSource authLocalDataSource;

  AuthRepositoryImpl({
    required this.authRemoteDataSource,
    required this.authLocalDataSource,
  });

  @override
  Future<Either<Failure, AuthResponse>> login({required LoginParam param}) async {
    try {
      AuthResponse authModel = await authRemoteDataSource.login(param: param);
      return Right(authModel);
    } on ServerException catch (exception) {
      return Left(ApiFailure(exception.message!));
    } catch (error) {
      return Left(Failure(error.toString()));
    }
  }

  @override
  Future<Either<Failure, String>> register({required RegisterParam param}) async {
    try {
      var model = await authRemoteDataSource.register(param: param);
      return Right(model);
    } on ServerException catch (exception) {
      return Left(ApiFailure(exception.message!));
    } catch (error) {
      return Left(Failure(error.toString()));
    }
  }

  @override
  Future<Either<Failure, AuthModel>> confirmCode({required ConfirmCodeParam param}) async {
    try {
      AuthModel authModel = await authRemoteDataSource.confirmCode(param: param);
      return Right(authModel);
    } on ServerException catch (exception) {
      return Left(ApiFailure(exception.message!));
    } catch (error) {
      return Left(Failure(error.toString()));
    }
  }

  @override
  Future<Either<Failure, String>> resendCode({required ResendCodeParam param}) async {
    try {
      String message = await authRemoteDataSource.resendCode(param: param);
      return Right(message.toString());
    } on ServerException catch (exception) {
      return Left(ApiFailure(exception.message!));
    } catch (error) {
      return Left(Failure(error.toString()));
    }
  }

  @override
  Future<Either<Failure, AuthModel>> verifyUser({required VerifyUserParam param}) async {
    try {
      var model = await authRemoteDataSource.verifyUser(param: param);
      return Right(model);
    } on ServerException catch (exception) {
      return Left(ApiFailure(exception.message!));
    } catch (error) {
      return Left(Failure(error.toString()));
    }
  }

  @override
  Future<Either<Failure, String>> saveUserData({
    required String token,
    required String id,
    String? accType,
    String? img,
    bool? isNotify,
    String? name,
    String? phone,
    String? cityId,
    String? cityName,
    String? licenseImg,
    String? formImg,
    String? carImg,
    String? location,
    String? carId,
    String? email,
    String? carName,
  }) async {
    try {
      await authLocalDataSource.saveDataUser(
          token: token,
          id: id,
          accType: accType,
          licenseImg: licenseImg,
          formImg: formImg,
          carImg: carImg,
          img: img,
          isNotify: isNotify,
          phone: phone,
          location: location,
          name: name,
          cityId: cityId,
          email: email,
          cityName: cityName,
          carId: carId,
          carName: carName);
      return const Right('Done');
    } on CacheException catch (exception) {
      return Left(CacheFailure(exception.message!));
    } catch (error) {
      return Left(Failure(error.toString()));
    }
  }

  @override
  Future<Either<Failure, List<StaticModel>>> getCars() async {
    try {
      List<StaticModel> model = await authRemoteDataSource.getCars();
      return Right(model);
    } on ServerException catch (exception) {
      return Left(ApiFailure(exception.message!));
    } catch (error) {
      return Left(Failure(error.toString()));
    }
  }

  @override
  Future<Either<Failure, List<StaticModel>>> getCities() async {
    try {
      List<StaticModel> model = await authRemoteDataSource.getCities();
      return Right(model);
    } on ServerException catch (exception) {
      return Left(ApiFailure(exception.message!));
    } catch (error) {
      return Left(Failure(error.toString()));
    }
  }
}
