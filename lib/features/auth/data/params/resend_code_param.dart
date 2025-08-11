import 'package:json_annotation/json_annotation.dart';

part 'resend_code_param.g.dart';

@JsonSerializable(createFactory: false)
class ResendCodeParam {
  @JsonKey(name: 'phone')
  final String phone;

  ResendCodeParam({
    required this.phone,
  });

  Map<String, dynamic> toJson() => _$ResendCodeParamToJson(this);
}
