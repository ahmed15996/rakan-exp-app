import 'package:json_annotation/json_annotation.dart';

part 'register_param.g.dart';

@JsonSerializable(createFactory: false, includeIfNull: true)
class RegisterParam {
  @JsonKey(name: 'name')
  final String? name;
  @JsonKey(name: 'phone')
  final String? phone;
  @JsonKey(name: 'email')
  final String? email;
  @JsonKey(name: 'id_number')
  final String? idNumber;
  @JsonKey(name: 'city_id')
  final String? cityId;
  @JsonKey(name: 'date_birth')
  final String? dateBirth;
  @JsonKey(name: 'device_key')
  final String? deviceKey;
  @JsonKey(name: 'car_id')
  final String? carId;
  @JsonKey(name: 'licence_img')
  final String? licenceImg;
  @JsonKey(name: 'form_img')
  final String? formImg;
  @JsonKey(name: 'car_img')
  final String? carImg;
  @JsonKey(name: 'img')
  final String? img;

  RegisterParam(
      {required this.name,
      required this.phone,
      required this.email,
      required this.idNumber,
      required this.cityId,
      required this.dateBirth,
      required this.deviceKey,
      required this.carId,
       this.img,
      required this.licenceImg,
      required this.formImg,
      required this.carImg});

  Map<String, dynamic> toJson() => _$RegisterParamToJson(this);
}
