import 'package:injectable/injectable.dart';
import '../models/static_model.dart';

import '../../../../../../core/api/api_consumer.dart';
import '../../../../../../core/api/base_response.dart';
import '../../../../../../core/constants/api_constants.dart';
import '../../../../../../core/errors/exceptions.dart';
import 'statics_data_source.dart';

@Injectable(as: StaticsDataSource)
class StaticsDataSourceImpl extends StaticsDataSource {
  final ApiConsumer apiConsumer;

  StaticsDataSourceImpl({required this.apiConsumer});

  @override
  Future<StaticValueModel> getData() async {
    BaseResponse response = await apiConsumer.get(
      ApiConstants.statics,
    );
    if (response.status) {
      return StaticValueModel.fromJson(response.data);
    } else {
      throw ServerException(response.message.toString());
    }
  }
}
