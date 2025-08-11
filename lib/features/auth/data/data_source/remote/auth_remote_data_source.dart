

import 'package:rakaan/core/models/general_model.dart';
import 'package:rakaan/core/models/static_model.dart';

import '../../models/auth_model.dart';
import '../../models/auth_response.dart';
import '../../params/confirm_code_param.dart';
import '../../params/login_param.dart';
import '../../params/register_param.dart';
import '../../params/resend_code_param.dart';
import '../../params/verify_user_param.dart';

abstract class AuthRemoteDataSource {
  Future<AuthResponse> login({required LoginParam param});
  Future<String> register({required RegisterParam param});
  Future<AuthModel> confirmCode({required ConfirmCodeParam param});
  Future<String> resendCode({required ResendCodeParam param});
  Future<AuthModel> verifyUser( {required VerifyUserParam param});
  Future<List<StaticModel>> getCars();
  Future<List<StaticModel>> getCities();
}
