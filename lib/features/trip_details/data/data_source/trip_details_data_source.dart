

import 'package:rakaan/features/home/data/models/trip_model.dart';

abstract class TripDetailsDataSource {
  Future<TripModel> getTrip({required String id});

}
