import 'package:server/enums/message_type.dart';

class Message {
  Message(this.message, this.username, this.type);

  final String message;
  final String username;
  final MessageType type;

  factory Message.fromJson(Map<String, dynamic> json) {
    return Message(
      json['message'] as String,
      json['username'] as String,
      MessageType.values.firstWhere(
        (element) => element.name == json['type'] as String,
      ),
    );
  }

  Map<String, String> toJson() {
    return {
      'message': message,
      'username': username,
      'type': type.name,
    };
  }
}
