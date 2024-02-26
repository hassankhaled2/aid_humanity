import 'package:aid_humanity/core/extensions/mediaquery_extension.dart';

import 'package:flutter/material.dart';

class ChatBubble extends StatelessWidget {
  const ChatBubble({super.key});

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerLeft,
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
            bottomLeft: Radius.circular(context.getDefaultSize() * 3),
            topRight: Radius.circular(context.getDefaultSize() * 3),
            bottomRight: Radius.circular(context.getDefaultSize() * 3),
            topLeft: Radius.elliptical(
                context.getDefaultSize(), context.getDefaultSize()),
          ),
          color: Colors.white,
          border: Border.all(
            color: Colors.black.withOpacity(0.3),
            width: 1.0,
          ),
        ),
        child: const Text("Iam a new user"),
      ),
    );
  }
}
