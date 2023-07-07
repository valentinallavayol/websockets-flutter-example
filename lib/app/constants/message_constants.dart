import 'package:flutter/material.dart';

class MessageConstants {
  static BorderRadius getBorderRadius({required bool sentByMe}) => sentByMe
      ? const BorderRadius.only(
          topLeft: Radius.circular(20),
          topRight: Radius.circular(20),
          bottomLeft: Radius.circular(20),
        )
      : const BorderRadius.only(
          topLeft: Radius.circular(20),
          topRight: Radius.circular(20),
          bottomRight: Radius.circular(20),
        );

  static Color? getBubbleColor(bool sentByMe) =>
      sentByMe ? Colors.lightGreen[300] : Colors.grey[300];

  static EdgeInsets getMargin(bool sentByMe) => sentByMe
      ? const EdgeInsets.only(left: 30)
      : const EdgeInsets.only(right: 30);

  static const padding =
      EdgeInsets.only(top: 17, bottom: 17, left: 20, right: 20);
}
