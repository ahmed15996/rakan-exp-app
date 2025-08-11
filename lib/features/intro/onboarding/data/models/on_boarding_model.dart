
import 'package:json_annotation/json_annotation.dart';

part 'on_boarding_model.g.dart';

@JsonSerializable(createToJson: false,includeIfNull: true)
class OnBoardingModel {
  @JsonKey(name: 'id')
  final int id;
  @JsonKey(name: 'title')
  final String? title;
  @JsonKey(name: 'desc')
  final String? desc;
  @JsonKey(name: 'img')
  final String? image;

  factory OnBoardingModel.fromJson(Map<String, dynamic> json) =>
      _$OnBoardingModelFromJson(json);

  OnBoardingModel({required this.id, required this.title, required this.desc, required this.image});
}
