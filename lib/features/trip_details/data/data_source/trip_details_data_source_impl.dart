import 'package:injectable/injectable.dart';

import '../../../../../core/api/api_consumer.dart';
import '../../../../../core/api/base_response.dart';
import '../../../../../core/constants/api_constants.dart';
import '../../../../../core/errors/exceptions.dart';
import '../../../home/data/models/trip_model.dart';
import 'trip_details_data_source.dart';

@Injectable(as: TripDetailsDataSource)
class TripDetailsDataSourceImpl extends TripDetailsDataSource {
  final ApiConsumer apiConsumer;

  TripDetailsDataSourceImpl({required this.apiConsumer});

  @override
  Future<TripModel> getTrip({required String id}) async {
    BaseResponse response = await apiConsumer.get(
      ApiConstants.getTrip(id),
    );
    if (response.status == true) {
      return TripModel.fromJson(response.data);
    } else {
      throw ServerException(response.message.toString());
    }
  }

}
