import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:message_repository/message_repository.dart';
import 'package:websockets_example/chat/bloc/chat_cubit.dart';
import 'package:websockets_example/chat/widgets/message_bubble.dart';
import 'package:websockets_example/chat/widgets/messages/text_message.dart';
import 'package:websockets_example/chat/widgets/messages/typing_message.dart';

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
            children: state.messages.reversed.map((message) {
              return MessageTile(
                  sentByMe: state.username == message.username,
                  child: message.type == MessageType.text
                      ? TextMessageContent(
                          sender: message.username, content: message.message)
                      : JumpingDots(
                          color: Colors.white,
                          jumpColor: Colors.white,
                          verticalOffset: -10,
                        ));
            }).toList(),
          ),
        );
      },
    );
  }
}
