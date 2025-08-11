import '../models/static_model.dart';

abstract class StaticsDataSource {
  Future<StaticValueModel> getData();
}
