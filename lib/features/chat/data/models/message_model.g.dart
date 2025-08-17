// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'message_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MessageModel _$MessageModelFromJson(Map<String, dynamic> json) => MessageModel(
      id: (json['id'] as num).toInt(),
      user: json['sender'] == null
          ? null
          : StaticModel.fromJson(json['sender'] as Map<String, dynamic>),
      admin: json['receive'] == null
          ? null
          : StaticModel.fromJson(json['receive'] as Map<String, dynamic>),
      type: json['type'] as String,
      message: json['message'] as String,
    );
