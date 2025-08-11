
import '../models/wallet_model.dart';
import '../param/wallet_param.dart';

abstract class WalletDataSource {
  Future<(List<WalletModel>,String?)> getData();
  Future<String> charge({required WalletParam param});
}
