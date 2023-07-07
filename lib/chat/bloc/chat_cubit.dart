import 'dart:async';
import 'dart:math';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:message_repository/message_repository.dart';

part 'chat_state.dart';

class ChatCubit extends Cubit<ChatState> {
  ChatCubit(
    final MessageRepository repository,
  )   : _messageRepository = repository,
        super(const ChatState(messages: [])) {
    setUserId();
    _streamSubscription = _messageRepository.messages().listen((message) {
      switch (message.type) {
        case MessageType.startedTyping:
          emit(state.copyWith(usersTyping: state.usersTyping + 1));
        case MessageType.stoppedTyping:
          emit(state.copyWith(usersTyping: state.usersTyping - 1));
        case MessageType.text:
          emit(
            state.copyWith(
                messages: [...(state.messages), message],
                usersTyping: (message.username == state.username)
                    ? state.usersTyping
                    : state.usersTyping - 1),
          );
        default:
      }
    });
  }

  final MessageRepository _messageRepository;
  late StreamSubscription _streamSubscription;

  void setUserId() {
    final username = _generateRandomString(5);
    _messageRepository.stablishConnection(username);
    emit(state.copyWith(username: _generateRandomString(5)));
  }

  String _generateRandomString(int lengthOfString) {
    final random = Random();
    const allChars =
        'AaBbCcDdlMmNnOoPpQqRrSsTtUuVvWwXxYyZz1EeFfGgHhIiJjKkL234567890';
    // below statement will generate a random string of length using the characters
    // and length provided to it
    final randomString = List.generate(lengthOfString,
        (index) => allChars[random.nextInt(allChars.length)]).join();
    return randomString; // return the generated string
  }

  void sendMessage() {
    if (state.currentMessage.isNotEmpty) {
      _messageRepository.addMessage(state.currentMessage, state.username);
    }
    emit(state.copyWith(currentMessage: ''));
  }

  updateCurrentMessage(String message) {
    if (state.currentMessage.isEmpty && message.isNotEmpty) {
      _messageRepository.startedTyping(state.username);
    }

    if (state.currentMessage.isNotEmpty && message.isEmpty) {
      _messageRepository.finishedTyping(state.username);
    }
    emit(state.copyWith(currentMessage: message));
  }

  @override
  Future<void> close() {
    _streamSubscription.cancel();
    return super.close();
  }
}
