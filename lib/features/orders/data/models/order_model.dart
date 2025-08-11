import 'package:json_annotation/json_annotation.dart';

part 'order_model.g.dart';

@JsonSerializable(createToJson: false, includeIfNull: true)
class OrderModel {
  @JsonKey(name: 'id')
  final int id;
  @JsonKey(name: 'code')
  final String? code;


  factory OrderModel.fromJson(Map<String, dynamic> json) => _$OrderModelFromJson(json);

  OrderModel({required this.id, required this.code});

}
