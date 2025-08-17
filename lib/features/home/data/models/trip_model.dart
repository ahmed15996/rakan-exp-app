import 'package:json_annotation/json_annotation.dart';
import 'package:rakaan/core/models/static_model.dart';
import 'package:rakaan/features/home/data/models/person_model.dart';

part 'trip_model.g.dart';

@JsonSerializable(createToJson: false, includeIfNull: true)
class TripModel {
  @JsonKey(name: 'id')
  final int id;
  @JsonKey(name: 'code')
  final int? code;
  @JsonKey(name: 'delivery')
  final String delivery;
  @JsonKey(name: 'status')
  final StaticModel? status;
  @JsonKey(name: 'payment')
  final StaticModel? payment;
  @JsonKey(name: 'service_provider')
  final PersonModel? serviceProvider;
  @JsonKey(name: 'clint')
  final PersonModel? clint;
  @JsonKey(name: 'time')
  final String? time;
  @JsonKey(name: 'seconds')
  final num? seconds;
  @JsonKey(name: 'total')
  final String? total;
  @JsonKey(name: 'items_count')
  final num? itemsCount;
  @JsonKey(name: 'isOpen')
  bool? isOpen;

  factory TripModel.fromJson(Map<String, dynamic> json) => _$TripModelFromJson(json);

  TripModel(
      {required this.id,
      required this.code,
      required this.total,
      required this.payment,
      required this.itemsCount,
      required this.seconds,
      this.isOpen = true,
      required this.status,
      required this.delivery,
      required this.serviceProvider,
      required this.clint,
      required this.time});
}
