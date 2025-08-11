// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'person_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PersonModel _$PersonModelFromJson(Map<String, dynamic> json) => PersonModel(
      id: (json['id'] as num?)?.toInt(),
      name: json['name'] as String?,
      img: json['img'] as String?,
      phone: json['phone'] as String?,
      lat: json['lat'] as num?,
      lng: json['lng'] as num?,
      location: json['location'] as String?,
      providerDistance: json['distance_to_service_provider'] as num?,
      clientDistance: json['distance_to_client'] as num?,
    );
