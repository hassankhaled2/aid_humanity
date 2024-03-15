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
List<QueryDocumentSnapshot>data=[];
bool isloading=true;

String FullName = '';
String Email = '';
String Phone = '';
String Address = '';
// String displayName='';
String photoUrl='';
getdata()async
{


  // QuerySnapShot --> to can take a data(list of document) from collection
  //FirebaseFirestore.instance.collection("categories").where("id",isEqualTo:FirebaseAuth.instance.currentUser!.uid ).get(); to get the data from firestore that belong to user
  QuerySnapshot querySnapshot=await FirebaseFirestore.instance.collection("UsersAuth").where("id",isEqualTo:FirebaseAuth.instance.currentUser!.uid, ).get();
  //addAll -->Appends all objects of [iterable] to the end of this list
  data.addAll(querySnapshot.docs);
  await Future.delayed(Duration(seconds: 2));
  isloading=false;
  final userData = data.first;
  FullName = userData['Full Name'];
  Email=userData['Email'];
  Phone=userData['Phone'];
  Address=userData['Address'];
  // علشان يعمل رفرش لليوزر انترفيس بعد  ال getdata

}

@override
void initState() {
  getdata();


}
class _ProfileWidgetState extends State<ProfileWidget> {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, mainAxisSize: MainAxisSize.min, children: [
        UserItemWidget(
          onTap: () {
            Navigator.push(context, MaterialPageRoute(builder: (context) =>  UserInfoPage(displayName: widget.displayName,email: widget.email,photoUrl:widget.photoUrl ,)));
          },
        ),
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
            ProfileItemWidget(icon: Icons.logout, text: context.translate("logout"), isModeWidget: false, iconColor: Colors.red, onTap:
                ()
            async {
              GoogleSignIn googleSign =GoogleSignIn();
              googleSign.disconnect();
              await FirebaseAuth.instance.signOut();
           Navigator.of(context).pushNamedAndRemoveUntil(AppRouter.login, (route) => false);
            }
            ),
          ]),
        )
      ]),
    );
  }
}
