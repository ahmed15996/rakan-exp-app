import 'package:json_annotation/json_annotation.dart';

part 'faq_model.g.dart';

@JsonSerializable(createToJson: false, includeIfNull: true)
class FaqModel {
  @JsonKey(name: 'title')
  final String title;
  @JsonKey(name: 'desc')
  final String? desc;

  factory FaqModel.fromJson(Map<String, dynamic> json) => _$FaqModelFromJson(json);

  FaqModel({required this.title, required this.desc});
}
