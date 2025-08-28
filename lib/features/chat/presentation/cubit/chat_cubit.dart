import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:flutter/widgets.dart';
import 'package:injectable/injectable.dart';
import 'package:pusher_channels_flutter/pusher_channels_flutter.dart';

import '../../../../core/constants/app_cached.dart';
import '../../../../core/local/shared_preferences/shared_pref_services.dart';
import '../../data/models/message_model.dart';
import '../../data/param/chat_param.dart';
import '../../data/repository/chat_repository.dart';

part 'chat_state.dart';

@injectable
class ChatCubit extends Cubit<ChatState> {
  ChatCubit(this.repository, this.pref) : super(ChatInitial());
  final ChatRepository repository;
  final SharedPrefServices pref;

  final msgController = TextEditingController();
  List<MessageModel> list=[];

  /// get chat
  void getData() async {
    emit(GetChatLoading());
    var result = await repository.getData();
    result.fold((failure) {
      emit(GetChatFailed(msg: failure.message));
    }, (data) {
      list = data;
      initPusher();
      emit(GetChatSuccess());
    });
  }

  /// send msg
  void sendMsg({required ChatParam param}) async {
    msgController.clear();
    emit(SendMessageLoading());
    var result = await repository.sendMsg(param: param);

    result.fold((failure) {
      emit(SendMessageFailed(msg: failure.message));
    }, (msg) {

      emit(SendMessageSuccess());
    });
  }

  /// pusher

  PusherChannelsFlutter pusher = PusherChannelsFlutter.getInstance();

  initPusher() async {
    try {

      await pusher.init(
        apiKey: "3f9d157327ca3f3c9e88",
        cluster: "eu",

        onConnectionStateChange: (currentState, previousState) {
          print("currentState ${currentState.toString()}" + previousState.toString());
        },
        onError: (message, code, error) {
          print("error pusher " + error + "........" + message);
        },
        onSubscriptionSucceeded: (channelName, data) {
          print("success pusher " + data.toString());
          print("channel pusher " + channelName.toString());
        },
        authParams: {
          'params': {'foo': 'bar'},
          'headers': {'baz': 'boo'}
        },
        onEvent: (event) async {
          if (event.eventName == "NewMessageSent") {
            debugPrint("Received name: ${event.eventName}");
            debugPrint("Received event: ${event.data}");
            await listen(data: event.data);
          } else {
            print("event name " + event.eventName);
          }
        },
      );
      await pusher.subscribe(channelName: 'chat.1');
      await pusher.connect();
    } catch (e) {
      print("ERROR: $e");
    }
  }

  Future<void> listen({required dynamic data}) async {
    try {
      if (data is String) {
        data = jsonDecode(data);
      }

      MessageModel? model = MessageModel.fromJson(data);

        list.insert(0,model) ;


      print("update model");
      emit(SocketUpdateState());
    } catch (e) {
      print("Error parsing Pusher event data: $e");
    }
  }
}
