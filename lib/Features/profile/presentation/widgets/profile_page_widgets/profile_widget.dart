import 'package:aid_humanity/Features/profile/presentation/pages/user_info_page.dart';
import 'package:aid_humanity/Features/profile/presentation/widgets/language_page_widgets/language_dialog_widget.dart';
import 'package:aid_humanity/Features/profile/presentation/widgets/profile_page_widgets/profile_item_widget.dart';
import 'package:aid_humanity/Features/profile/presentation/widgets/profile_page_widgets/profile_user_item_widget.dart';
import 'package:aid_humanity/core/extensions/mediaquery_extension.dart';
import 'package:aid_humanity/core/extensions/translation_extension.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';

import '../../../../../core/utils/app_router/app_router.dart';

class ProfileWidget extends StatefulWidget {
  const ProfileWidget({super.key, required this.displayName, required this.email, required this.photoUrl});
  final String displayName;
  final String email;
  final String  photoUrl;

  @override
  State<ProfileWidget> createState() => _ProfileWidgetState();
}


class _ProfileWidgetState extends State<ProfileWidget> {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, mainAxisSize: MainAxisSize.min,
          children: [
            UserItemWidget(),
            Padding(
          padding: EdgeInsets.symmetric(horizontal: context.getDefaultSize() * 2),
          child: Column(children: [
            ProfileItemWidget(
              onTap: () {
                showDialog(
                  context: context,
                  builder: (context) => AlertDialog(
                    title: Text(
                        context.translate(
                          "change_language",
                        ),
                        textAlign: TextAlign.center,
                        style: const TextStyle(fontWeight: FontWeight.bold)),
                    shape: const RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(10.0))),
                    content: const LangageDialogWidget(),
                    titlePadding: const EdgeInsets.all(15),
                    contentPadding: EdgeInsets.zero,
                    insetPadding: EdgeInsets.zero,
                    clipBehavior: Clip.values[3],
                  ),
                );
              },
              icon: Icons.language,
              text: context.translate("language"),
              isModeWidget: false,
            ),
            ProfileItemWidget(icon: Icons.notifications_outlined, text: context.translate("notification"), isModeWidget: true, onTap: () {}),
            ProfileItemWidget(icon: Icons.history, text: context.translate("history"), isModeWidget: false, onTap: () {}),
            ProfileItemWidget(icon: Icons.help, text: context.translate("help"), isModeWidget: false, onTap: () {}),
            ProfileItemWidget(icon: Icons.info_outline, text: context.translate("about"), isModeWidget: false, onTap: () {}),
            ProfileItemWidget(icon: Icons.logout, text: context.translate("logout"), isModeWidget: false, iconColor: Colors.red, onTap: ()
            async {
              GoogleSignIn googleSign =GoogleSignIn();
                 googleSign.disconnect();
               FirebaseAuth.instance.signOut();
           Navigator.of(context).pushNamedAndRemoveUntil(AppRouter.login, (route) => false);
            }
            ),
          ]),
        )
      ]),
    );
  }
}
