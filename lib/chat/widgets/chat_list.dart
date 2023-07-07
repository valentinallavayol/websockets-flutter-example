import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:message_repository/message_repository.dart';
import 'package:websockets_example/chat/bloc/chat_cubit.dart';
import 'package:websockets_example/chat/widgets/messages/message_bubble.dart';
import 'package:websockets_example/chat/widgets/messages/text_message.dart';
import 'package:websockets_example/chat/widgets/messages/typing_message.dart';
import 'package:websockets_example/chat/widgets/messages/welcome_message.dart';

class ChatList extends StatelessWidget {
  const ChatList({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ChatCubit, ChatState>(
      builder: (context, state) {
        return Positioned.fill(
          bottom: MediaQuery.sizeOf(context).height * 0.13,
          child: Column(
            children: [
              Expanded(
                child: ListView(
                  reverse: true,
                  children: state.messages.reversed.map((message) {
                    return _buildMessage(message,
                        sentByMe: state.username == message.username);
                  }).toList(),
                ),
              ),
              if (state.usersTyping != 0) ...[
                MessageTile(
                  sentByMe: false,
                  child: JumpingDots(
                    color: Colors.white,
                    jumpColor: Colors.white,
                    verticalOffset: -10,
                  ),
                ),
              ]
            ],
          ),
        );
      },
    );
  }

  Widget _buildMessage(Message message, {bool sentByMe = false}) {
    switch (message.type) {
      case MessageType.text:
        return MessageTile(
          sentByMe: sentByMe,
          child: TextMessageContent(
            sender: message.username,
            content: message.message,
            sentByMe: sentByMe,
          ),
        );

      case MessageType.connectionStablished:
        return WelcomeMessage(message: message);
      default:
        return Container();
    }
  }
}
