import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:message_repository/message_repository.dart';
import 'package:web_socket_channel/web_socket_channel.dart';
import 'package:websockets_example/testFeature/bloc/message_cubit.dart';
import 'package:websockets_example/testFeature/view/my_app.dart';

import 'bootstrap.dart';

void main() {
  bootstrap(() async {
    const baseUrl = String.fromEnvironment('API_URL');

    final uri = Uri.parse('$baseUrl/ws');
    final channel = WebSocketChannel.connect(uri);

    final messageRepository = MessageRepository(webSocketChannel: channel);

    return BlocProvider(
      create: (context) => ChatCubit(messageRepository),
      child: const MyApp(),
    );
  });
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    const title = 'WebSocket Demo';
    return const MaterialApp(
      title: title,
      home: MyHomePage(title: title),
    );
  }
}
