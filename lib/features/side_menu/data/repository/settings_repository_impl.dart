import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';

import '../../../../../core/errors/exceptions.dart';
import '../../../../core/errors/failures.dart';
import '../../../auth/data/models/auth_response.dart';
import '../../../auth/data/models/user_model.dart';
import '../../../auth/data/params/register_param.dart';
import '../data_source/settings_remote_data_source.dart';
import '../params/profile_param.dart';
import 'settings_repository.dart';

@Injectable(as: SettingsRepository)
class SettingsRepositoryImpl extends SettingsRepository {
  final SettingsRemoteDataSource remoteDataSource;

  SettingsRepositoryImpl({
    required this.remoteDataSource,
  });

  @override
  Future<Either<Failure, String>> toggleNotification() async {
    try {
      String msg = await remoteDataSource.toggleNotification();
      return Right(msg);
    } on ServerException catch (exception) {
      return Left(ApiFailure(exception.message!));
    } catch (error) {
      return Left(Failure(error.toString()));
    }
  }



  @override
  Future<Either<Failure, String>> logout() async {
    try {
      String message = await remoteDataSource.logout();
      return Right(message);
    } on ServerException catch (exception) {
      return Left(ApiFailure(exception.message!));
    } catch (error) {
      return Left(Failure(error.toString()));
    }
  }

  @override
  Future<Either<Failure, String>> deleteAccount() async {
    try {
      String message = await remoteDataSource.deleteAccount();
      return Right(message);
    } on ServerException catch (exception) {
      return Left(ApiFailure(exception.message!));
    } catch (error) {
      return Left(Failure(error.toString()));
    }
  }

  @override
  Future<Either<Failure, AuthResponse>> editProfile({required RegisterParam param}) async {
    try {
      AuthResponse msg = await remoteDataSource.editProfile(param: param);
      return Right(msg);
    } on ServerException catch (exception) {
      return Left(ApiFailure(exception.message!));
    } catch (error) {
      return Left(Failure(error.toString()));
    }
  }

}
