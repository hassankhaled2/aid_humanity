import 'package:aid_humanity/Features/profile/presentation/widgets/profile_item_widget.dart';
import 'package:aid_humanity/Features/profile/presentation/widgets/profile_user_item_widget.dart';
import 'package:aid_humanity/core/extensions/mediaquery_extension.dart';
import 'package:flutter/material.dart';

class ProfileWidget extends StatelessWidget {
  const ProfileWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, mainAxisSize: MainAxisSize.min, children: [
        Padding(
          padding: EdgeInsets.only(left: context.getDefaultSize() * 2.5, right: context.getDefaultSize() * 2.5, bottom: context.getDefaultSize() * 0.9, top: context.getDefaultSize()),
          child: const UserItemWidget(),
        ),
        Divider(
          color: Colors.grey[200],
          thickness: 1.5,
          endIndent: 0,
        ),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: context.getDefaultSize() * 2),
          child: Column(children: [
            const ProfileItemWidget(icon: Icons.language, text: "Language", isModeWidget: false),
            Divider(
              color: Colors.grey[200],
              thickness: 1.5,
            ),
            const ProfileItemWidget(icon: Icons.notifications_outlined, text: "Notification", isModeWidget: true),
            Divider(
              color: Colors.grey[200],
              thickness: 1.5,
            ),
            const ProfileItemWidget(icon: Icons.history, text: "History", isModeWidget: false),
            Divider(
              color: Colors.grey[200],
              thickness: 1.5,
            ),
            const ProfileItemWidget(icon: Icons.help, text: "Help", isModeWidget: false),
            Divider(
              color: Colors.grey[200],
              thickness: 1.5,
            ),
            const ProfileItemWidget(icon: Icons.info_outline, text: "About", isModeWidget: false),
            Divider(
              color: Colors.grey[200],
              thickness: 1.5,
            )
          ]),
        )
      ]),
    );
  }
}
