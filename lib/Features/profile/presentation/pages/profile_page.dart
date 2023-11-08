import 'package:aid_humanity/Features/profile/presentation/widgets/profile_widget.dart';

import 'package:aid_humanity/core/widgets/defualt_app_bar_widget.dart';
import 'package:flutter/material.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBar(context),
      body: _buildBody(),
    );
  }

  AppBar _buildAppBar(BuildContext context) => getDefaultAppBarWidget(context: context, title: "Profile",color: Colors.black,);

  Widget _buildBody() => const ProfileWidget();
}
