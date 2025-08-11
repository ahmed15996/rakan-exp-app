import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';

import '../../../../../../core/errors/exceptions.dart';
import '../../../../../../core/errors/failures.dart';
import '../data_source/wallet_data_source.dart';
import '../models/wallet_model.dart';
import '../param/wallet_param.dart';
import 'wallet_repository.dart';

@Injectable(as: WalletRepository)
class WalletRepositoryImpl extends WalletRepository {
  final WalletDataSource walletDataSource;

  WalletRepositoryImpl({required this.walletDataSource});

  @override
  Future<Either<Failure,(List<WalletModel>,String?)>> getData() async {
    try {
      (List<WalletModel>,String?) data = await walletDataSource.getData();
      return Right(data);
    } on ServerException catch (exception) {
      return Left(ApiFailure(exception.message!));
    } catch (error) {
      return Left(Failure(error.toString()));
    }
  }

  @override
  Future<Either<Failure, String>> charge({required WalletParam param}) async {
    try {
      String data = await walletDataSource.charge(param: param);
      return Right(data);
    } on ServerException catch (exception) {
      return Left(ApiFailure(exception.message!));
    } catch (error) {
      return Left(Failure(error.toString()));
    }
  }
}
