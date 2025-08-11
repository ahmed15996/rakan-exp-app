import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';

import '../../../../core/errors/exceptions.dart';
import '../../../../core/errors/failures.dart';
import '../../../home/data/models/trip_model.dart';
import '../data_source/trip_details_data_source.dart';
import 'trip_details_repository.dart';

@Injectable(as: TripDetailsRepository)
class TripDetailsRepositoryImpl extends TripDetailsRepository {
  final TripDetailsDataSource tripDetailsDataSource;

  TripDetailsRepositoryImpl({required this.tripDetailsDataSource});

  @override
  Future<Either<Failure, TripModel>> getTrip({required String id}) async {
    try {
      TripModel model = await tripDetailsDataSource.getTrip(id: id);
      return Right(model);
    } on ServerException catch (exception) {
      return Left(ApiFailure(exception.message!));
    } catch (error) {
      return Left(Failure(error.toString()));
    }
  }
}
