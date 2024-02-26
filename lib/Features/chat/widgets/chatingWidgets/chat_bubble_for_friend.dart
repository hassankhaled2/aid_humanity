import 'package:aid_humanity/core/extensions/mediaquery_extension.dart';
import 'package:aid_humanity/core/utils/constants.dart';
import 'package:flutter/material.dart';

class ChatBubbleForFriend extends StatelessWidget {
  const ChatBubbleForFriend({super.key});

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerRight,
      child: Container(
        padding: EdgeInsets.only(
          top: context.getDefaultSize() * 1.5,
          bottom: context.getDefaultSize() * 1.5,
          left: context.getDefaultSize() * 2,
          right: context.getDefaultSize() * 2,
        ),
        margin: EdgeInsets.all(context.getDefaultSize()),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(context.getDefaultSize() * 3),
              bottomRight: Radius.circular(context.getDefaultSize() * 3),
              bottomLeft: Radius.circular(context.getDefaultSize() * 3),
              topRight: Radius.elliptical(
                  context.getDefaultSize(), context.getDefaultSize())),
          color: kPrimaryColor.withOpacity(0.2),
          border: Border.all(
            color: Colors.black.withOpacity(0.3),
            width: 1.0,
          ),
        ),
        child: const Text("Welcome For you"),
      ),
    );
  }
}
