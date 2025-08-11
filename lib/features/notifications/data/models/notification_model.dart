import 'package:json_annotation/json_annotation.dart';

part 'notification_model.g.dart';

@JsonSerializable(createToJson: false, includeIfNull: true)
class NotificationModel {
  @JsonKey(name: 'id')
  final String id;
  @JsonKey(name: 'title')
  final String title;
  @JsonKey(name: 'message')
  final String? message;
  @JsonKey(name: 'image')
  final String image;
  @JsonKey(name: 'created_at')
  final String? createdAt;

  factory NotificationModel.fromJson(Map<String, dynamic> json) => _$NotificationModelFromJson(json);

  NotificationModel({required this.id, required this.title, required this.message, required this.image, required this.createdAt});
}
