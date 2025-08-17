import 'package:json_annotation/json_annotation.dart';
import 'package:rakaan/features/home/data/models/trip_model.dart';

part 'home_model.g.dart';

@JsonSerializable(createToJson: false, includeIfNull: true)
class HomeModel {
  @JsonKey(name: 'balance')
  final num? balance;
  @JsonKey(name: 'online')
   bool? online;
  @JsonKey(name: 'accepted')
  final num? accepted;
  @JsonKey(name: 'orders_count')
  final num? ordersCount;
  @JsonKey(name: 'seconds')
  final num? seconds;
  @JsonKey(name: 'offers')
  final List<TripModel>? offers;

  factory HomeModel.fromJson(Map<String, dynamic> json) => _$HomeModelFromJson(json);

  HomeModel(
      {required this.balance,
      required this.online,
      required this.accepted,
      required this.ordersCount,
      required this.seconds,
      required this.offers});
}
