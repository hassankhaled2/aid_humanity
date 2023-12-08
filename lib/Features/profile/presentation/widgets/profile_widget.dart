import 'package:aid_humanity/Features/profile/presentation/widgets/profile_item_widget.dart';
import 'package:aid_humanity/Features/profile/presentation/widgets/profile_user_item_widget.dart';
import 'package:aid_humanity/core/extensions/mediaquery_extension.dart';
import 'package:aid_humanity/core/extensions/translation_extension.dart';
import 'package:aid_humanity/core/widgets/custom_divider_widget.dart';
import 'package:flutter/material.dart';

class ProfileWidget extends StatelessWidget {
  const ProfileWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, mainAxisSize: MainAxisSize.min, children: [
        const CustomDividerWidget(),
        Padding(
          padding: EdgeInsets.only(
            left: context.getDefaultSize() * 2.5,
            right: context.getDefaultSize() * 2.5,
            bottom: context.getDefaultSize() * 0.9,
          ),
          child: const UserItemWidget(),
        ),
        const CustomDividerWidget(),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: context.getDefaultSize() * 2),
          child: Column(children: [
            ProfileItemWidget(
              icon: Icons.language,
              text: context.translate("language"),
              isModeWidget: false,
            ),
            const CustomDividerWidget(),
            ProfileItemWidget(icon: Icons.notifications_outlined, text: context.translate("notification"), isModeWidget: true),
            const CustomDividerWidget(),
            ProfileItemWidget(icon: Icons.history, text: context.translate("history"), isModeWidget: false),
            const CustomDividerWidget(),
            ProfileItemWidget(icon: Icons.help, text: context.translate("help"), isModeWidget: false),
            const CustomDividerWidget(),
            ProfileItemWidget(icon: Icons.info_outline, text: context.translate("about"), isModeWidget: false),
            const CustomDividerWidget(),
            ProfileItemWidget(icon: Icons.logout, text: context.translate("logout"), isModeWidget: false, iconColor: Colors.red),
            const CustomDividerWidget(),
          ]),
        )
      ]),
    );
  }
}
