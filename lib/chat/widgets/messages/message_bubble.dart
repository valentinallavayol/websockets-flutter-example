import 'package:flutter/material.dart';
import 'package:websockets_example/app/constants/message_constants.dart';

class MessageTile extends StatelessWidget {
  final bool sentByMe;
  final Widget child;

  const MessageTile({Key? key, required this.sentByMe, required this.child})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(
          top: 4, bottom: 4, left: sentByMe ? 0 : 24, right: sentByMe ? 24 : 0),
      alignment: sentByMe ? Alignment.centerRight : Alignment.centerLeft,
      margin: MessageConstants.getMargin(sentByMe),
      child: Container(
        padding: MessageConstants.padding,
        decoration: BoxDecoration(
            borderRadius: MessageConstants.getBorderRadius(sentByMe: sentByMe),
            color: MessageConstants.getBubbleColor(sentByMe)),
        child: child,
      ),
    );
  }
}
