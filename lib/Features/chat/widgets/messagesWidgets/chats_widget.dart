import 'package:aid_humanity/Features/chat/widgets/messagesWidgets/user_chats_item.dart';

import 'package:aid_humanity/core/widgets/custom_divider_widget.dart';
import 'package:flutter/material.dart';

class ChatsWidget extends StatelessWidget {
  const ChatsWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return const  Padding(padding: EdgeInsets.all(8.0),child: Column(children: [UserChatItem(),CustomDividerWidget(),UserChatItem(),CustomDividerWidget(),UserChatItem()],),);
  }
}
