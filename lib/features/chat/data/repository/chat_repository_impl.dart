import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';

import '../../../../../../core/errors/exceptions.dart';
import '../../../../../../core/errors/failures.dart';
import '../data_source/chat_data_source.dart';
import '../models/message_model.dart';
import '../param/chat_param.dart';
import 'chat_repository.dart';

@Injectable(as: ChatRepository)
class ChatRepositoryImpl extends ChatRepository {
  final ChatDataSource chatDataSource;

  ChatRepositoryImpl({required this.chatDataSource});

  @override
  Future<Either<Failure, List<MessageModel>>> getData() async {
    try {
      List<MessageModel> data = await chatDataSource.getData();
      return Right(data);
    } on ServerException catch (exception) {
      return Left(ApiFailure(exception.message!));
    } catch (error) {
      return Left(Failure(error.toString()));
    }
  }

  @override
  Future<Either<Failure, String>> sendMsg({required ChatParam param}) async {
    try {
      String data = await chatDataSource.sendMsg(param: param);
      return Right(data);
    } on ServerException catch (exception) {
      return Left(ApiFailure(exception.message!));
    } catch (error) {
      return Left(Failure(error.toString()));
    }
  }
}
