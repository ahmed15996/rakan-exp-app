import '../../../home/data/models/trip_model.dart';

class OrderStatusArguments {
   TripModel model;
   final void Function()? onUpdate;

  OrderStatusArguments({required this.model,required this.onUpdate});

}
