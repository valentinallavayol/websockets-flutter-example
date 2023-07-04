import 'dart:convert';

import 'package:server/models/message.dart' as serverMessage;
import 'package:web_socket_channel/web_socket_channel.dart';

import 'models/message.dart';

/// {@template message_repository}
/// A Very Good Project created by Very Good CLI.
/// {@endtemplate}
class MessageRepository {
  /// {@macro message_repository}
  MessageRepository({
    required WebSocketChannel webSocketChannel,
  }) : _webSocketChannel = webSocketChannel;

  final WebSocketChannel _webSocketChannel;

  void addMessage(String message, String username) {
    final newMessage = Message(message, username);

    _webSocketChannel.sink.add(jsonEncode(newMessage.toJson()));
  }

  Stream<Message> messages() async* {
    await for (final message in _webSocketChannel.stream) {
      final decodedMessage = serverMessage.Message.fromJson(
        jsonDecode(message as String) as Map<String, dynamic>,
      );

      final transformedMessage = Message(
        decodedMessage.message,
        decodedMessage.username,
      );
      print("ME LLEGO AL REPO $transformedMessage");
      yield* Stream.value(transformedMessage);
    }
  }
}
