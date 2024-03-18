import 'package:aid_humanity/Features/profile/presentation/widgets/profile_page_widgets/profile_widget.dart';
import 'package:aid_humanity/core/extensions/translation_extension.dart';
import 'package:aid_humanity/core/widgets/defualt_app_bar_widget.dart';
import 'package:flutter/material.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key, required this.displayName, required this.email, required this.photoUrl});
  final String displayName;
  final String email;
  final String  photoUrl;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBar(context),
      body: _buildBody(),
    );
  }

  AppBar _buildAppBar(BuildContext context) => getDefaultAppBarWidget(
        context: context,
        title: context.translate("profile"),
        color: Colors.black,
      );

  Widget _buildBody() =>  ProfileWidget(photoUrl: photoUrl,email:email ,displayName:displayName ,);
}
