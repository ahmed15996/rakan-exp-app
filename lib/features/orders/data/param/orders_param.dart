import 'package:json_annotation/json_annotation.dart';

part 'orders_param.g.dart';

@JsonSerializable(createFactory: false, includeIfNull: true,)
class OrdersParam {
  @JsonKey(name: 'type_order')
   final String? typeOrder;
  @JsonKey(name: 'type')
  final String? type;

  OrdersParam({required this.typeOrder, required this.type});




  Map<String, dynamic> toJson() => _$OrdersParamToJson(this);
}
