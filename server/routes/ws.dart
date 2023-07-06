import 'dart:convert';

import 'package:dart_frog/dart_frog.dart';
import 'package:dart_frog_web_socket/dart_frog_web_socket.dart';
import 'package:server/enums/message_type.dart';
import 'package:server/models/message.dart';

List<dynamic> clients = <dynamic>[];

Handler get onRequest {
  return webSocketHandler((channel, protocol) {
    print('connected');

    clients.add(channel);
    print(clients);

    // final otherClients = clients.where((element) => element != channel);

    // for (final client in clients) {
    //   final coso = client as WebSocketChannel;
    //   if (coso != channel) {
    //     coso.sink.add(Message("New member joined, '")"holaaaaa");
    //   }

    //   // client.stream.listen();
    // }

    channel.stream.listen(
      (message) {
        //  print("Message from server side " + message.toString());
        final decodedMessage = Message.fromJson(
            jsonDecode(message as String) as Map<String, dynamic>);

        _handleMessage(channel, decodedMessage);
        // // Handle incoming client messages.
        // for (final element in clients) {
        //   (element as WebSocketChannel).sink.add(coso);
        // }
        print("Message from server side " + message.toString());
        // Handle incoming client messages.
        // for (final element in clients) {
        //   (element as WebSocketChannel).sink.add(message);
        // }
      },
      onDone: () {
        print('disconnected');
        clients.remove(channel);
      },
    );

    // Send a message back to the client.
  });
}

void _handleMessage(WebSocketChannel senderChannel, Message message) {
  switch (message.type) {
    case MessageType.text:
      print("Message from server side TEXT" + message.message);
      _handleTextMessage(message);
      break;
    case MessageType.startedTyping:
    case MessageType.stoppedTyping:
      print("Message from server side TYPING " + message.message);
      _handleTypingMessage(senderChannel, message);
      break;
    default:
  }
}

void _handleTextMessage(Message message) {
  for (final element in clients) {
    element.sink.add(jsonEncode(message.toJson()));
  }
}

void _handleTypingMessage(WebSocketChannel senderChannel, Message message) {
  final otherClients = clients.where((channel) => channel != senderChannel);
  for (final client in otherClients) {
    client.sink.add(jsonEncode(message.toJson()));
  }
}
