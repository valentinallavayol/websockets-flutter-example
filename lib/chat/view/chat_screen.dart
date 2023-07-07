import 'package:flutter/material.dart';
import 'package:websockets_example/chat/widgets/chat_list.dart';
import 'package:websockets_example/chat/widgets/chat_textfield.dart';

class ChatScreen extends StatelessWidget {
  const ChatScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Padding(
      padding: EdgeInsets.symmetric(horizontal: 6),
      child: Stack(
        children: [
          ChatList(),
          ChatTextField(),
        ],
      ),
    );
  }
}
