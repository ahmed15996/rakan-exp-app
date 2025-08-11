// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserModel _$UserModelFromJson(Map<String, dynamic> json) => UserModel(
      id: (json['id'] as num).toInt(),
      name: json['name'] as String,
      phone: json['phone'] as String?,
      deviceKey: json['device_key'] as String?,
      email: json['email'] as String?,
      dateBirth: json['date_birth'] as String?,
      car: StaticModel.fromJson(json['car'] as Map<String, dynamic>),
      city: StaticModel.fromJson(json['city'] as Map<String, dynamic>),
      img: json['img'] as String?,
      location: json['location'] as String?,
      idNumber: json['id_number'] as String?,
      licenceImg: json['licence_img'] as String?,
      formImg: json['form_img'] as String?,
      carImg: json['car_img'] as String?,
      isNotify: json['is_notify'] as bool?,
    );
