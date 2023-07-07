part of 'chat_cubit.dart';

class ChatState extends Equatable {
  const ChatState(
      {required this.messages,
      this.username = '',
      this.currentMessage = '',
      this.usersTyping = 0});

  final List<Message> messages;
  final String username;
  final String currentMessage;
  final int usersTyping;

  ChatState copyWith(
      {List<Message>? messages,
      String? username,
      String? currentMessage,
      int? usersTyping}) {
    return ChatState(
      currentMessage: currentMessage ?? this.currentMessage,
      messages: messages ?? this.messages,
      username: username ?? this.username,
      usersTyping: usersTyping ?? this.usersTyping,
    );
  }

  @override
  List<Object?> get props => [messages, username, currentMessage, usersTyping];
}
