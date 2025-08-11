import 'package:injectable/injectable.dart';

import '../../../../../../core/api/api_consumer.dart';
import '../../../../../../core/api/base_response.dart';
import '../../../../../../core/constants/api_constants.dart';
import '../../../../../../core/errors/exceptions.dart';
import '../models/wallet_model.dart';
import '../param/wallet_param.dart';
import 'wallet_data_source.dart';

@Injectable(as: WalletDataSource)
class WalletDataSourceImpl extends WalletDataSource {
  final ApiConsumer apiConsumer;

  WalletDataSourceImpl({required this.apiConsumer});

  @override
  Future<(List<WalletModel>,String?)> getData() async {
    BaseResponse response = await apiConsumer.get(
      ApiConstants.wallet,
    );
    if (response.status) {
      return (List.from(response.data['wallet']).map((e) => WalletModel.fromJson(e)).toList(),response.data['balance'].toString());
    } else {
      throw ServerException(response.message.toString());
    }
  }

  @override
  Future<String> charge({required WalletParam param}) async {
    BaseResponse response = await apiConsumer.post(
      ApiConstants.walletCharging,
      body: param.toJson()
    );
    if (response.status) {
      return response.message;
    } else {
      throw ServerException(response.message.toString());
    }
  }

}
