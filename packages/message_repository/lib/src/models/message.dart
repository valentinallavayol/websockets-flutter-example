class Message {
  Message(this.message, this.username);

  final String message;
  final String username;

  factory Message.fromJson(Map<String, dynamic> json) {
    return Message(
      json['message'] as String,
      json['username'] as String,
    );
  }

  Map<String, String> toJson() {
    return {
      'message': message,
      'username': username,
    };
  }
}
