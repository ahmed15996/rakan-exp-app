import 'package:json_annotation/json_annotation.dart';

part 'login_param.g.dart';

@JsonSerializable(createFactory: false)
class LoginParam {

@JsonKey(name: 'phone')
 final String phone;
   @JsonKey(name: 'device_key')
  final String deviceToken;

  LoginParam({

    required this.phone,
    required this.deviceToken,
  });

  Map<String, dynamic> toJson() => _$LoginParamToJson(this);
}