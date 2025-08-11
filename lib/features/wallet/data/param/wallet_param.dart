import 'package:json_annotation/json_annotation.dart';

part 'wallet_param.g.dart';

@JsonSerializable(createFactory: false, includeIfNull: true,)
class WalletParam {
  @JsonKey(name: 'balance')
   final String balance;
  @JsonKey(name: 'transaction_id')
  final String transactionId;

  WalletParam({required this.balance, required this.transactionId});



  Map<String, dynamic> toJson() => _$WalletParamToJson(this);
}
