import 'package:injectable/injectable.dart';

import '../../../../../../core/api/api_consumer.dart';
import '../../../../../../core/api/base_response.dart';
import '../../../../../../core/constants/api_constants.dart';
import '../../../../../../core/errors/exceptions.dart';
import '../params/contact_and_report_param.dart';
import 'contact_and_report_data_source.dart';

@Injectable(as: ContactAndReportDataSource)
class ContactAndReportDataSourceImpl extends ContactAndReportDataSource {
  final ApiConsumer apiConsumer;

  ContactAndReportDataSourceImpl({required this.apiConsumer});

  @override
  Future<String> addContactAndReport({required ContactAndReportParam param}) async {
    Map<String, dynamic> body = {
      if (param.name != null) 'name': param.name,
      if (param.email != null) 'email': param.email,
      if (param.message != null) 'msg': param.message,
      if (param.subject != null) 'resson': param.subject,
    };
    BaseResponse response = await apiConsumer.post(
      ApiConstants.contact,
      body: body,
    );
    if (response.status) {
      return response.message;
    } else {
      throw ServerException(response.message.toString());
    }
  }
}
