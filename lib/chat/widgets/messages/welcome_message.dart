import 'package:flutter/material.dart';
import 'package:message_repository/message_repository.dart';

class WelcomeMessage extends StatelessWidget {
  const WelcomeMessage({super.key, required this.message});

  final Message message;
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Text(
          message.message.toUpperCase(),
          style: const TextStyle(
            fontSize: 14,
            letterSpacing: 2,
            // fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
        ),
      ),
    );
  }
}
