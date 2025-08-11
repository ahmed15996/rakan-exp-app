// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'trip_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TripModel _$TripModelFromJson(Map<String, dynamic> json) => TripModel(
      id: (json['id'] as num).toInt(),
      code: (json['code'] as num?)?.toInt(),
      total: json['total'] as String?,
      payment: json['payment'] == null
          ? null
          : StaticModel.fromJson(json['payment'] as Map<String, dynamic>),
      itemsCount: json['items_count'] as num?,
      seconds: json['seconds'] as num?,
      isOpen: json['isOpen'] as bool? ?? true,
      status: json['status'] == null
          ? null
          : StaticModel.fromJson(json['status'] as Map<String, dynamic>),
      delivery: (json['delivery'] as num?)?.toInt(),
      serviceProvider: json['service_provider'] == null
          ? null
          : PersonModel.fromJson(
              json['service_provider'] as Map<String, dynamic>),
      clint: json['clint'] == null
          ? null
          : PersonModel.fromJson(json['clint'] as Map<String, dynamic>),
      time: json['time'] as String?,
    );
