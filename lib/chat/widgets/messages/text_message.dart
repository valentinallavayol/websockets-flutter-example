import 'package:flutter/material.dart';

class TextMessageContent extends StatelessWidget {
  const TextMessageContent({
    super.key,
    required this.sender,
    required this.content,
    required this.sentByMe,
  });

  final String sender;
  final String content;
  final bool sentByMe;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (!sentByMe) ...[
          Text(
            sender.toUpperCase(),
            textAlign: TextAlign.start,
            style: const TextStyle(
                fontSize: 13,
                // fontWeight: FontWeight.bold,
                color: Colors.red,
                letterSpacing: -0.5),
          ),
          const SizedBox(
            height: 8,
          ),
        ],
        Text(content,
            textAlign: TextAlign.start,
            style: const TextStyle(fontSize: 16, color: Colors.black))
      ],
    );
  }
}
