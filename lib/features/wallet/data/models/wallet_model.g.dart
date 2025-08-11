// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'wallet_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

WalletModel _$WalletModelFromJson(Map<String, dynamic> json) => WalletModel(
      id: (json['id'] as num).toInt(),
      balance: json['balance'] as String,
      title: json['title'] as String?,
      msg: json['msg'] as String?,
      createdAt: json['created_at'] as String?,
      symbol: json['symbol'] as String?,
    );
