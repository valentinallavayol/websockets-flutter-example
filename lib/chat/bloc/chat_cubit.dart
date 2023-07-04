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
      print("ME LLEGO Al CUBIT $message");
      emit(
        state.copyWith(messages: [
          ...state.messages,
          message,
        ]),
      );
    });
  }

  final MessageRepository _messageRepository;
  late StreamSubscription _streamSubscription;

  void setUserId() {
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
    emit(state.copyWith(currentMessage: message));
  }

  @override
  Future<void> close() {
    _streamSubscription.cancel();
    return super.close();
  }
}
