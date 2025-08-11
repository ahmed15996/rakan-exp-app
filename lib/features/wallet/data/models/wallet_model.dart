import 'package:json_annotation/json_annotation.dart';

part 'wallet_model.g.dart';

@JsonSerializable(createToJson: false, includeIfNull: true)
class WalletModel {
  @JsonKey(name: 'id')
  final int id;
  @JsonKey(name: 'balance')
  final String balance;
  @JsonKey(name: 'title')
  final String? title;
  @JsonKey(name: 'msg')
  final String? msg;
  @JsonKey(name: 'created_at')
  final String? createdAt;
  @JsonKey(name: 'symbol')
  final String? symbol;

  factory WalletModel.fromJson(Map<String, dynamic> json) => _$WalletModelFromJson(json);

  WalletModel({required this.id, required this.balance, required this.title, required this.msg, required this.createdAt, required this.symbol});


}
