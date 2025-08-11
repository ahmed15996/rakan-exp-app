import 'package:json_annotation/json_annotation.dart';

part 'static_model.g.dart';

@JsonSerializable(createToJson: false, includeIfNull: true)
class StaticModel {
  @JsonKey(name: 'id')
  final int id;
  @JsonKey(name: 'name')
  final String? name;
  @JsonKey(name: 'img')
  final String? img;



  factory StaticModel.fromJson(Map<String, dynamic> json) => _$StaticModelFromJson(json);

  StaticModel({required this.id, required this.name, required this.img});

}
