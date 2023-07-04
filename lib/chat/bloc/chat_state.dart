part of 'chat_cubit.dart';

class ChatState extends Equatable {
  const ChatState(
      {required this.messages, this.username = '', this.currentMessage = ''});

  final List<Message> messages;
  final String username;
  final String currentMessage;

  ChatState copyWith({
    List<Message>? messages,
    String? username,
    String? currentMessage,
  }) {
    return ChatState(
      currentMessage: currentMessage ?? this.currentMessage,
      messages: messages ?? this.messages,
      username: username ?? this.username,
    );
  }

  @override
  List<Object?> get props => [messages, username, currentMessage];
}
