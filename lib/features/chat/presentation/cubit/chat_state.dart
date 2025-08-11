part of 'chat_cubit.dart';

@immutable
abstract class ChatState {}

class ChatInitial extends ChatState {}
class SocketUpdateState extends ChatState {}

/// get data
class GetChatLoading extends ChatState {}

class GetChatSuccess extends ChatState {}

class GetChatFailed extends ChatState {
  final String msg;

  GetChatFailed({required this.msg});
}

/// send message
class SendMessageLoading extends ChatState {}

class SendMessageSuccess extends ChatState {}

class SendMessageFailed extends ChatState {
  final String msg;

  SendMessageFailed({required this.msg});
}
