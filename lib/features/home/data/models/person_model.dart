import 'package:json_annotation/json_annotation.dart';
import 'package:rakaan/core/models/static_model.dart';

part 'person_model.g.dart';

@JsonSerializable(createToJson: false, includeIfNull: true)
class PersonModel {

  @JsonKey(name: 'id')
  final int? id;
  @JsonKey(name: 'name')
  final String? name;
  @JsonKey(name: 'phone')
  final String? phone;
  @JsonKey(name: 'img')
  final String? img;
  @JsonKey(name: 'lat')
  final num? lat;
  @JsonKey(name: 'lng')
  final num? lng;
  @JsonKey(name: 'location')
  final String? location;
  @JsonKey(name: 'distance_to_service_provider')
  final num? providerDistance;
  @JsonKey(name: 'distance_to_client')
  final num? clientDistance;
  factory PersonModel.fromJson(Map<String, dynamic> json) => _$PersonModelFromJson(json);

  PersonModel({required this.id, required this.name, required this.img, required this.phone, required this.lat, required this.lng, required this.location, required this.providerDistance, required this.clientDistance});




}
