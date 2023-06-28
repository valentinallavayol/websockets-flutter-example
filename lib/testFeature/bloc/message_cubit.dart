import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:message_repository/message_repository.dart';

part 'message_state.dart';

class ChatCubit extends Cubit<ChatState> {
  ChatCubit(
    final MessageRepository repository,
  )   : _messageRepository = repository,
        super(const ChatState(messages: [])) {
    _streamSubscription = _messageRepository.messages().listen((message) {
      print("ME LLEGO Al CUBIT $message");
      emit(
        ChatState(messages: [
          ...state.messages,
          message,
        ]),
      );
    });
  }

  final MessageRepository _messageRepository;
  late StreamSubscription _streamSubscription;

  void sendMessage(String message) {
    if (message.isNotEmpty) {
      _messageRepository.addMessage(message);
    }
  }

  @override
  Future<void> close() {
    _streamSubscription.cancel();
    return super.close();
  }
}
