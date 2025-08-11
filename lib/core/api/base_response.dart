import 'package:json_annotation/json_annotation.dart';

part 'base_response.g.dart';

@JsonSerializable(createToJson: false, genericArgumentFactories: true)
class BaseResponse{
  @JsonKey(name: 'status')
  final bool status;

  @JsonKey(name: 'data')
  final dynamic data;
  @JsonKey(name: 'message')
  final dynamic message;

  BaseResponse({
    required this.status,

    required this.data,
    required this.message,
  });

  factory BaseResponse.fromJson(Map<String, dynamic> json) =>
      _$BaseResponseFromJson(json);
}
