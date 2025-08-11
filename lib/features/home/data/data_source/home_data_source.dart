import '../models/home_model.dart';
import '../param/location_param.dart';
import '../param/online_param.dart';

abstract class HomeDataSource {
  Future<HomeModel> getTrip();

  Future<String> updateLocation({required LocationParam param});
  Future<String> updateOnline({required OnlineParam param});
}
