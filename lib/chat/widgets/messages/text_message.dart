import 'package:flutter/material.dart';

class TextMessageContent extends StatelessWidget {
  const TextMessageContent({
    super.key,
    required this.sender,
    required this.content,
  });

  final String sender;
  final String content;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          sender.toUpperCase(),
          textAlign: TextAlign.start,
          style: const TextStyle(
              fontSize: 13,
              fontWeight: FontWeight.bold,
              color: Colors.white,
              letterSpacing: -0.5),
        ),
        const SizedBox(
          height: 8,
        ),
        Text(content,
            textAlign: TextAlign.start,
            style: const TextStyle(fontSize: 16, color: Colors.white))
      ],
    );
  }
}
