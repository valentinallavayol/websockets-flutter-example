import 'dart:convert';

import 'package:message_repository/message_repository.dart';
import 'package:web_socket_channel/web_socket_channel.dart';

/// {@template message_repository}
/// A Very Good Project created by Very Good CLI.
/// {@endtemplate}
class MessageRepository {
  /// {@macro message_repository}
  MessageRepository({
    required WebSocketChannel webSocketChannel,
  }) : _webSocketChannel = webSocketChannel;

  final WebSocketChannel _webSocketChannel;

  void startedTyping(String username) {
    final newMessage = Message('', username, MessageType.startedTyping);

    _webSocketChannel.sink.add(jsonEncode(newMessage.toJson()));
  }

  void finishedTyping(String username) {
    final newMessage = Message('', username, MessageType.stoppedTyping);

    _webSocketChannel.sink.add(jsonEncode(newMessage.toJson()));
  }

  void addMessage(String message, String username) {
    final newMessage = Message(message, username, MessageType.text);

    _webSocketChannel.sink.add(jsonEncode(newMessage.toJson()));
  }

  Stream<Message> messages() async* {
    await for (final message in _webSocketChannel.stream) {
      final decodedMessage = Message.fromJson(
        jsonDecode(message as String) as Map<String, dynamic>,
      );

      print("ME LLEGO AL REPO $decodedMessage");
      yield* Stream.value(decodedMessage);
    }
  }
}
