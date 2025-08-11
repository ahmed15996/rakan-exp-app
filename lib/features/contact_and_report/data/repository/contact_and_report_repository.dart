import 'package:dartz/dartz.dart';

import '../../../../../core/errors/failures.dart';
import '../params/contact_and_report_param.dart';

abstract class ContactAndReportRepository {


  Future<Either<Failure, String>> addContactAndReport({required ContactAndReportParam param});
}
