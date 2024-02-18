import 'package:aid_humanity/Features/chat/widgets/messagesWidgets/chats_widget.dart';

import 'package:aid_humanity/core/extensions/translation_extension.dart';

import 'package:aid_humanity/core/widgets/defualt_app_bar_widget.dart';
import 'package:flutter/material.dart';

class ChatsPage extends StatelessWidget {
  const ChatsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBar(context),
      body: _buildBody(),
    );
  }

  AppBar _buildAppBar(BuildContext context) => getDefaultAppBarWidget(
        context: context,
        title: context.translate("Chats"),
        color: Colors.black,
      );

  Widget _buildBody() => const ChatsWidget();
}
