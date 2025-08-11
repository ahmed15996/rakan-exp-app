
import '../models/on_boarding_model.dart';

abstract class OnBoardingDataSource {
  Future<List<OnBoardingModel>> getData();

}
