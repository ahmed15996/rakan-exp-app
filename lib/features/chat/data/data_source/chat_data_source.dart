import '../models/message_model.dart';
import '../param/chat_param.dart';

abstract class ChatDataSource {
  Future<String> sendMsg({required ChatParam param});

  Future<List<MessageModel>> getData();
}
