
import 'package:aid_humanity/Features/home/presentation/widgets/choise_Item.dart';
import 'package:aid_humanity/Features/profile/presentation/widgets/language_page_widgets/language_dialog_widget.dart';
import 'package:aid_humanity/Features/profile/presentation/widgets/profile_page_widgets/profile_item_widget.dart';
import 'package:aid_humanity/Features/profile/presentation/widgets/profile_page_widgets/profile_user_item_widget.dart';
import 'package:aid_humanity/core/extensions/mediaquery_extension.dart';
import 'package:aid_humanity/core/extensions/translation_extension.dart';
import 'package:aid_humanity/core/widgets/custom_divider_widget.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:shared_preferences/shared_preferences.dart';


import '../../../../../core/utils/app_router/app_router.dart';
import '../../../../../core/utils/theme/App_theme.dart';
import '../../../../../core/utils/theme/cubit/theme_cubit.dart';

class ProfileWidget extends StatefulWidget {
  const ProfileWidget({super.key,});


  @override
  State<ProfileWidget> createState() => _ProfileWidgetState();
}

class _ProfileWidgetState extends State<ProfileWidget> {
  bool isDarkTheme=true;
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
            ListTile(
              title: Text('Change Theme',style: TextStyle( fontWeight: FontWeight.bold,),),
              trailing: Switch(
                activeColor: Colors.orange,
                value: isDarkTheme,
                onChanged: (value) {
                  setState(() {
                    isDarkTheme = value;
                  });

                  final selectedTheme = isDarkTheme ? AppTheme.values[1] : AppTheme.values[0];
                  context.read<ThemeCubit>().changeTheme(selectedTheme);
                },
              ),
            ),
            CustomDividerWidget(),
            ProfileItemWidget(icon: Icons.history, text: context.translate("history"), isModeWidget: false, onTap: () {}),
            ProfileItemWidget(icon: Icons.help, text: context.translate("help"), isModeWidget: false, onTap: () {}),
            ProfileItemWidget(icon: Icons.info_outline, text: context.translate("about"), isModeWidget: false, onTap: ()
            async{
        /// remove it later
              Navigator.of(context).push(MaterialPageRoute(builder: (context)=>ChoiceItem()));
            }),
            ProfileItemWidget(icon: Icons.logout, text: context.translate("logout"), isModeWidget: false, iconColor: Colors.red, onTap: ()
            async {
              String keyToRemove = "userType";
              SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
              sharedPreferences.remove(keyToRemove);
              // await FirebaseAuth.instance.currentUser!.delete();
              GoogleSignIn googleSign =GoogleSignIn();
                 googleSign.disconnect();

               FirebaseAuth.instance.signOut();
           Navigator.of(context).pushNamedAndRemoveUntil(AppRouter.login, (route) => false);
           //    Navigator.of(context).pushNamedAndRemoveUntil(AppRouter.choicePage, (route) => false);
            }
            ),
          ]),
        )
      ]),
    );
  }
}
