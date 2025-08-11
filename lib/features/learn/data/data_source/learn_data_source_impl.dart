import 'package:injectable/injectable.dart';

import '../../../../../../core/api/api_consumer.dart';
import '../../../../../../core/api/base_response.dart';
import '../../../../../../core/constants/api_constants.dart';
import '../../../../../../core/errors/exceptions.dart';
import 'learn_data_source.dart';

@Injectable(as: LearnDataSource)
class LearnDataSourceImpl extends LearnDataSource {
  final ApiConsumer apiConsumer;

  LearnDataSourceImpl({required this.apiConsumer});

  @override
  Future<String> getData() async {
    BaseResponse response = await apiConsumer.get(
       ApiConstants.footer ,
    );
    if (response.status) {
      return response.data['video'];
    } else {
      throw ServerException(response.message.toString());
    }
  }
}
