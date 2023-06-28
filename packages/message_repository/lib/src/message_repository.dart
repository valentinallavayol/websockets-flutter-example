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

  void addMessage(String message) {
    _webSocketChannel.sink.add(message);
  }

  Stream<String> messages() async* {
    await for (var message in _webSocketChannel.stream) {
      print("ME LLEGO AL REPO $message");
      yield* Stream.value(message as String);
    }
  }
}
