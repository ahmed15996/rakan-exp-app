import 'package:dartz/dartz.dart';

import '../../../../../../core/errors/failures.dart';
import '../models/message_model.dart';
import '../param/chat_param.dart';

abstract class ChatRepository {
  Future<Either<Failure, List<MessageModel>>> getData();

  Future<Either<Failure, String>> sendMsg({required ChatParam param});
}
