

import 'package:rakaan/features/home/data/models/trip_model.dart';

import '../param/order_status_param.dart';

abstract class OrderStatusDataSource {
  Future<TripModel> changeStatus({required OrderStatusParam param});
  Future<TripModel> uploadImg({required OrderStatusParam param});

}
