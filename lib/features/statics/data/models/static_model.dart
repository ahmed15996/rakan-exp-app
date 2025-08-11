import 'package:json_annotation/json_annotation.dart';

part 'static_model.g.dart';

@JsonSerializable(createToJson: false, includeIfNull: true)
class StaticValueModel {
  @JsonKey(name: 'orders_count_today')
  final num? ordersCountToday;
  @JsonKey(name: 'wallet_today')
  final num? walletToday;
  @JsonKey(name: 'orders_count')
  final num? ordersCount;
  @JsonKey(name: 'wallet')
  final num? wallet;

  factory StaticValueModel.fromJson(Map<String, dynamic> json) => _$StaticValueModelFromJson(json);

  StaticValueModel({required this.ordersCountToday, required this.walletToday, required this.ordersCount, required this.wallet});

}
