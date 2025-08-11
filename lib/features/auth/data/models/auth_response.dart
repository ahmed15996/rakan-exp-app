import 'auth_model.dart';

class AuthResponse {
  final AuthModel? authModel;
  final String? message;

  AuthResponse({required this.authModel, required this.message});
}