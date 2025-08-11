import 'package:dartz/dartz.dart';

import '../../../../../core/errors/failures.dart';
import '../../../auth/data/models/auth_response.dart';
import '../../../auth/data/models/user_model.dart';
import '../../../auth/data/params/register_param.dart';
import '../params/profile_param.dart';

abstract class SettingsRepository {

  Future<Either<Failure, String>> logout();
  Future<Either<Failure, String>> deleteAccount();
  Future<Either<Failure, AuthResponse>> editProfile({required RegisterParam param});
  Future<Either<Failure, String>> toggleNotification();
}
