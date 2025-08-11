import 'package:injectable/injectable.dart';

import '../../../../../../core/api/api_consumer.dart';
import '../../../../../../core/api/base_response.dart';
import '../../../../../../core/constants/api_constants.dart';
import '../../../../../../core/errors/exceptions.dart';
import 'static_page_data_source.dart';

@Injectable(as: StaticPageDataSource)
class StaticPageDataSourceImpl extends StaticPageDataSource {
  final ApiConsumer apiConsumer;

  StaticPageDataSourceImpl({required this.apiConsumer});

  @override
  Future<String> getData({required bool forAbout}) async {
    BaseResponse response = await apiConsumer.get(
      forAbout ? ApiConstants.aboutUs : ApiConstants.terms,
    );
    if (response.status) {
      return response.data;
    } else {
      throw ServerException(response.message.toString());
    }
  }
}
