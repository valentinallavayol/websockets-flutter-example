import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:websockets_example/chat/bloc/chat_cubit.dart';
import 'package:websockets_example/chat/widgets/chat_list.dart';
import 'package:websockets_example/chat/widgets/chat_textfield.dart';

class ChatScreen extends StatelessWidget {
  const ChatScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 6),
      child: BlocBuilder<ChatCubit, ChatState>(
        builder: (context, state) {
          return const Stack(
            children: [
              ChatList(),
              ChatTextField(),
            ],
          );
        },
      ),
    );
  }
}
