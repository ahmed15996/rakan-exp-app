import 'package:json_annotation/json_annotation.dart';
import 'package:rakaan/core/models/static_model.dart';

part 'message_model.g.dart';

@JsonSerializable(createToJson: false, includeIfNull: true)
class MessageModel {
  @JsonKey(name: 'id')
  final int id;
  @JsonKey(name: 'sender')
  final StaticModel? user;
  @JsonKey(name: 'receive')
  final StaticModel? admin;
  @JsonKey(name: 'type')
  final String type;
  @JsonKey(name: 'message')
  final String message;

  factory MessageModel.fromJson(Map<String, dynamic> json) => _$MessageModelFromJson(json);

  MessageModel({required this.id, required this.user, required this.admin, required this.type, required this.message});

}
