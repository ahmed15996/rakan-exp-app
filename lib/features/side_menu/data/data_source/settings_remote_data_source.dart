import '../../../auth/data/models/auth_response.dart';
import '../../../auth/data/params/register_param.dart';

abstract class SettingsRemoteDataSource {
  Future<String> logout();

  Future<String> deleteAccount();

  Future<AuthResponse> editProfile({required RegisterParam param});

  Future<String> toggleNotification();
}
