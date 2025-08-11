import 'package:json_annotation/json_annotation.dart';

import '../../../../core/helpers/enums.dart';

part 'order_status_param.g.dart';

@JsonSerializable(createFactory: false, includeIfNull: true,)
class OrderStatusParam {
  @JsonKey(name: 'statusType')
   final StatusType statusType;
  @JsonKey(name: 'order_id')
  final String? id;
  @JsonKey(name: 'restaurant_img')
  final String? acceptImg;
  @JsonKey(name: 'delivered_img')
  final String? receiveImg;
  @JsonKey(name: 'completed_img')
  final String? deliverImg;

  OrderStatusParam({required this.statusType, required this.id,  this.acceptImg,  this.receiveImg,  this.deliverImg});






  Map<String, dynamic> toJson() => _$OrderStatusParamToJson(this);
}
