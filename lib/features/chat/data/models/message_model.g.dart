// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'message_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MessageModel _$MessageModelFromJson(Map<String, dynamic> json) => MessageModel(
      id: (json['id'] as num).toInt(),
      user: json['user'] == null
          ? null
          : StaticModel.fromJson(json['user'] as Map<String, dynamic>),
      admin: json['admin'] == null
          ? null
          : StaticModel.fromJson(json['admin'] as Map<String, dynamic>),
      type: json['type'] as String,
      message: json['message'] as String,
    );
