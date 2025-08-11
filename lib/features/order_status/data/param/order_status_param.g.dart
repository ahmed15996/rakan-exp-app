// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'order_status_param.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Map<String, dynamic> _$OrderStatusParamToJson(OrderStatusParam instance) =>
    <String, dynamic>{
      'statusType': _$StatusTypeEnumMap[instance.statusType]!,
      'order_id': instance.id,
      'restaurant_img': instance.acceptImg,
      'delivered_img': instance.receiveImg,
      'completed_img': instance.deliverImg,
    };

const _$StatusTypeEnumMap = {
  StatusType.accept: 'accept',
  StatusType.receive: 'receive',
  StatusType.deliver: 'deliver',
};
