import 'package:aid_humanity/Features/chat/widgets/chatingWidgets/chat_bubble.dart';
import 'package:aid_humanity/Features/chat/widgets/chatingWidgets/chating_appbar.dart';
import 'package:aid_humanity/Features/chat/widgets/chatingWidgets/chating_widget.dart';
import 'package:aid_humanity/core/widgets/defualt_app_bar_widget.dart';

import 'package:flutter/material.dart';

class ChatingPage extends StatelessWidget {
  const ChatingPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: chatingAppBar(context),
      body: _buildBody(),
    );
  }

  Widget _buildBody() => const ChatingWidget();
}
