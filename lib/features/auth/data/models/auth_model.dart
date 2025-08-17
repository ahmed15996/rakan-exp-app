import 'package:json_annotation/json_annotation.dart';
import 'package:rakaan/features/auth/data/models/user_model.dart';

part 'auth_model.g.dart';

@JsonSerializable(createToJson: false, includeIfNull: true)
class AuthModel {
  @JsonKey(name: 'is_active')
  final bool? isActive;

  @JsonKey(name: 'is_available')
  final bool? isAvailable;
  @JsonKey(name: 'is_pending')
  final bool? isBending;
  @JsonKey(name: 'user')
  final UserModel? user;

  @JsonKey(name: 'token')
  final String? token;

  factory AuthModel.fromJson(Map<String, dynamic> json) => _$AuthModelFromJson(json);

  AuthModel({required this.isActive, required this.isAvailable,required this.isBending, required this.user, required this.token});

}
