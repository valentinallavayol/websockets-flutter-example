import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:websockets_example/chat/bloc/chat_cubit.dart';
import 'package:websockets_example/chat/widgets/message_bubble.dart';

class ChatList extends StatelessWidget {
  const ChatList({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ChatCubit, ChatState>(
      builder: (context, state) {
        return Positioned.fill(
          bottom: MediaQuery.sizeOf(context).height * 0.13,
          child: ListView(
            reverse: true,
            children: state.messages.reversed
                .map((message) => MessageTile(
                    message: message.message,
                    sender: message.username,
                    sentByMe: state.username == message.username))
                .toList(),
          ),
        );
      },
    );
  }
}
