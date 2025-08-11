
import 'package:json_annotation/json_annotation.dart';
part 'profile_param.g.dart';

@JsonSerializable(createFactory: false,includeIfNull: true)
class ProfileParam {
  final String? name, avatar, email, gender;

  ProfileParam({
    this.name,
    this.avatar,
    this.email,
    this.gender,
  });


  Map<String, dynamic> toJson() => _$ProfileParamToJson(this);
}
