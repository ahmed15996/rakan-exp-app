import 'package:json_annotation/json_annotation.dart';

part 'online_param.g.dart';

@JsonSerializable(createFactory: false, includeIfNull: true)
class OnlineParam {
  @JsonKey(name: 'is_online')
  final int isOnline;

  OnlineParam({required this.isOnline});



  Map<String, dynamic> toJson() => _$OnlineParamToJson(this);
}
