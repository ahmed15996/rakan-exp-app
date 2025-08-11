import 'package:json_annotation/json_annotation.dart';

part 'confirm_code_param.g.dart';

@JsonSerializable(createFactory: false)
class ConfirmCodeParam {

  @JsonKey(name: 'phone')
  final String phone;

  @JsonKey(name: 'otp')
  final String otp;

  ConfirmCodeParam({required this.phone, required this.otp});



  Map<String, dynamic> toJson() => _$ConfirmCodeParamToJson(this);
}
