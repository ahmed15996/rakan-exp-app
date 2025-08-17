// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'home_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

HomeModel _$HomeModelFromJson(Map<String, dynamic> json) => HomeModel(
      balance: json['balance'] as num?,
      online: json['online'] as bool?,
      accepted: json['accepted'] as num?,
      ordersCount: json['orders_count'] as num?,
      seconds: json['seconds'] as num?,
      offers: (json['offers'] as List<dynamic>?)
          ?.map((e) => TripModel.fromJson(e as Map<String, dynamic>))
          .toList(),
    );
