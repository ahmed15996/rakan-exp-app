
import '../params/contact_and_report_param.dart';

abstract class ContactAndReportDataSource {

  Future<String> addContactAndReport({required ContactAndReportParam param});

}
