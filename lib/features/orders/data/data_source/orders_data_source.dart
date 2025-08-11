import 'package:rakaan/features/home/data/models/trip_model.dart';
import 'package:rakaan/features/orders/data/models/order_model.dart';

import '../../../../core/models/general_model.dart';
import '../param/orders_param.dart';


abstract class OrdersDataSource {
  Future<List<TripModel>> getData({required OrdersParam param});
}
