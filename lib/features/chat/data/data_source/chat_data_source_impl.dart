import 'package:injectable/injectable.dart';

import '../../../../../../core/api/api_consumer.dart';
import '../../../../../../core/api/base_response.dart';
import '../../../../../../core/errors/exceptions.dart';
import '../../../../core/constants/api_constants.dart';
import '../models/message_model.dart';
import '../param/chat_param.dart';
import 'chat_data_source.dart';

@Injectable(as: ChatDataSource)
class ChatDataSourceImpl extends ChatDataSource {
  final ApiConsumer apiConsumer;

  ChatDataSourceImpl({required this.apiConsumer});

  @override
  Future<List<MessageModel>> getData() async {
    BaseResponse response = await apiConsumer.get(ApiConstants.getChats);
    if (response.status) {
      return List.from(response.data).map((e) => MessageModel.fromJson(e)).toList();
    } else {
      throw ServerException(response.message.toString());
    }
  }

  @override
  Future<String> sendMsg({required ChatParam param}) async {
    BaseResponse response = await apiConsumer.post(ApiConstants.sendMsg, body: param.toJson());
    if (response.status) {
      return response.message;
    } else {
      throw ServerException(response.message.toString());
    }
  }
}
