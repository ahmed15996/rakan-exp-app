import 'package:json_annotation/json_annotation.dart';

part 'chat_param.g.dart';

@JsonSerializable(createFactory: false, includeIfNull: true)
class ChatParam {
  @JsonKey(name: 'message')
  final String message;

  ChatParam({required this.message});



  Map<String, dynamic> toJson() => _$ChatParamToJson(this);
}
