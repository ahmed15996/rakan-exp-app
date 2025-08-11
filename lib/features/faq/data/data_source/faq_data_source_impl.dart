import 'package:injectable/injectable.dart';
import '../models/faq_model.dart';

import '../../../../../../core/api/api_consumer.dart';
import '../../../../../../core/api/base_response.dart';
import '../../../../../../core/constants/api_constants.dart';
import '../../../../../../core/errors/exceptions.dart';
import 'faq_data_source.dart';

@Injectable(as: FaqDataSource)
class FaqDataSourceImpl extends FaqDataSource {
  final ApiConsumer apiConsumer;

  FaqDataSourceImpl({required this.apiConsumer});

  @override
  Future<List<FaqModel>> getData() async {
    BaseResponse response = await apiConsumer.get(
      ApiConstants.questions,
    );
    if (response.status) {
      return List.from(response.data).map((e) => FaqModel.fromJson(e)).toList();
    } else {
      throw ServerException(response.message.toString());
    }
  }
}
