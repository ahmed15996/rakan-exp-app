import 'package:dartz/dartz.dart';

import '../../../../../../core/errors/failures.dart';
import '../models/wallet_model.dart';
import '../param/wallet_param.dart';



abstract class WalletRepository {
  Future<Either<Failure, (List<WalletModel>,String?)>> getData();
  Future<Either<Failure, String>> charge({required WalletParam param});
}
