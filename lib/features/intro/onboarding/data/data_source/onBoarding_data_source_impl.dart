import 'package:injectable/injectable.dart';


import '../../../../../../core/api/api_consumer.dart';
import '../../../../../../core/api/base_response.dart';
import '../../../../../../core/constants/api_constants.dart';
import '../../../../../../core/errors/exceptions.dart';
import '../models/on_boarding_model.dart';
import 'onBoarding_data_source.dart';

@Injectable(as: OnBoardingDataSource)
class OnBoardingDataSourceImpl extends OnBoardingDataSource {
  final ApiConsumer apiConsumer;

  OnBoardingDataSourceImpl({required this.apiConsumer});



  @override
  Future<List<OnBoardingModel>> getData() async {
    BaseResponse response = await apiConsumer.get(
      ApiConstants.onBoarding,

    );
    if (response.status) {
      return List.from(response.data).map((e) => OnBoardingModel.fromJson(e)).toList();
    } else {
      throw ServerException(response.message.toString());
    }
  }

}
