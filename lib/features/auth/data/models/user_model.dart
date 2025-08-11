import 'package:json_annotation/json_annotation.dart';
import 'package:rakaan/core/models/static_model.dart';

part 'user_model.g.dart';

@JsonSerializable(createToJson: false, includeIfNull: true)
class UserModel {
  @JsonKey(name: 'id')
  final int id;
  @JsonKey(name: 'name')
  final String name;
  @JsonKey(name: 'phone')
  final String? phone;
  @JsonKey(name: 'device_key')
  final String? deviceKey;
  @JsonKey(name: 'email')
  final String? email;
  @JsonKey(name: 'date_birth')
  final String? dateBirth;
  @JsonKey(name: 'car')
  final StaticModel car;
  @JsonKey(name: 'city')
  final StaticModel city;

  @JsonKey(name: 'img')
  final String? img;
  @JsonKey(name: 'location')
  final String? location;
  @JsonKey(name: 'id_number')
  final String? idNumber;
  @JsonKey(name: 'licence_img')
  final String? licenceImg;
  @JsonKey(name: 'form_img')
  final String? formImg;
  @JsonKey(name: 'car_img')
  final String? carImg;
  @JsonKey(name: 'is_notify')
  final bool? isNotify;

  factory UserModel.fromJson(Map<String, dynamic> json) => _$UserModelFromJson(json);

  UserModel(
      {required this.id,
      required this.name,
      required this.phone,
      required this.deviceKey,
      required this.email,
      required this.dateBirth,
      required this.car,
      required this.city,
      required this.img,
      required this.location,
      required this.idNumber,
      required this.licenceImg,
      required this.formImg,
      required this.carImg,
      required this.isNotify});
}
