import 'package:json_annotation/json_annotation.dart';

part 'location_param.g.dart';

@JsonSerializable(createFactory: false, includeIfNull: true)
class LocationParam {
  @JsonKey(name: 'lat')
  final String lat;
  @JsonKey(name: 'long')
  final String long;
  @JsonKey(name: 'address')
  final String? address;

  LocationParam({required this.lat, required this.long, required this.address});


  Map<String, dynamic> toJson() => _$LocationParamToJson(this);
}
