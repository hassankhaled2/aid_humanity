import 'package:aid_humanity/Features/chat/widgets/chatingWidgets/chat_bubble.dart';
import 'package:aid_humanity/Features/chat/widgets/chatingWidgets/chat_bubble_for_friend.dart';
import 'package:aid_humanity/core/extensions/mediaquery_extension.dart';
import 'package:aid_humanity/core/utils/constants.dart';
import 'package:flutter/material.dart';

class ChatingWidget extends StatelessWidget {
  const ChatingWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: ListView(
            children: const [
              ChatBubble(),
              ChatBubbleForFriend(),
              ChatBubble(),
              ChatBubbleForFriend(),
              ChatBubble(),
              ChatBubbleForFriend(),
              ChatBubble(),
              ChatBubbleForFriend(),
              ChatBubble(),
              ChatBubbleForFriend(),
            ],
          ),
        ),
        chatingTextField(context),
      ],
    );
  }

  Padding chatingTextField(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(context.getDefaultSize() * 2),
      child: TextField(
        cursorColor: kPrimaryColor,
        decoration: InputDecoration(
            hintText: 'Send Message',
            suffixIcon: Icon(
              Icons.send,
              color: kPrimaryColor,
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(context.getDefaultSize() * 2),
              borderSide: BorderSide(color: kPrimaryColor),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(context.getDefaultSize() * 2),
              borderSide: BorderSide(color: kPrimaryColor),
            )),
      ),
    );
  }
}
