import 'package:json_annotation/json_annotation.dart';

part 'contact_and_report_param.g.dart';

@JsonSerializable(createFactory: false, includeIfNull: true)
class ContactAndReportParam {
  final String? name, message, email, subject;

  ContactAndReportParam({
    this.name,
    this.email,
    this.message,
    this.subject,
  });

  Map<String, dynamic> toJson() => _$ContactAndReportParamToJson(this);
}
