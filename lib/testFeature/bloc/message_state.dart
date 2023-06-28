part of 'message_cubit.dart';

class ChatState extends Equatable {
  const ChatState({required this.messages});

  final List<String> messages;
  @override
  List<Object?> get props => [messages];
}
