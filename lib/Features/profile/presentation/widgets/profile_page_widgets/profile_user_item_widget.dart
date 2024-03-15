import 'package:aid_humanity/core/extensions/mediaquery_extension.dart';
import 'package:aid_humanity/core/utils/theme/app_color/app_color_light.dart';
import 'package:aid_humanity/core/widgets/custom_divider_widget.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
// اللى برا
class UserItemWidget extends StatefulWidget {
  const UserItemWidget({super.key,  this.onTap});
  final Function()? onTap;


  @override
  State<UserItemWidget> createState() => _UserItemWidgetState();
}

class _UserItemWidgetState extends State<UserItemWidget> {
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
    // await Future.delayed(Duration(seconds: 2));
    isloading=false;
    final userData = data.first;
    FullName = userData['Full Name'];
    Email=userData['Email'];
    Phone=userData['Phone'];
    Address=userData['Address'];
    // علشان يعمل رفرش لليوزر انترفيس بعد  ال getdata
    setState(() {

    });
  }
  final user = FirebaseAuth.instance.currentUser;

  @override
  void initState() {
    getdata();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: widget.onTap,
      child: SizedBox(
        width: double.infinity,
        height: context.getDefaultSize() * 6,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const CustomDividerWidget(),
            Expanded(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: context.getDefaultSize() * 1.5),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    CircleAvatar(
                      backgroundImage:  NetworkImage(
                         ""
                      ),
                      radius: context.getDefaultSize() * 2,
                    ),
                    SizedBox(
                      width: context.getDefaultSize() * 1.2,
                    ),
                    Expanded(
                        child: Column(crossAxisAlignment: CrossAxisAlignment.start, mainAxisAlignment: MainAxisAlignment.center, children: [
                      Text(
                        FullName,
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: context.getDefaultSize() * 1.8,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      SizedBox(
                        height: context.getDefaultSize() * 0.3,
                      ),
                      Text(
                        Phone,
                        style: TextStyle(color: AppColorsLight.primaryColor, fontSize: context.getDefaultSize() * 1.4, overflow: TextOverflow.ellipsis),
                      ),
                    ])),
                    const Spacer(),
                    Icon(Icons.navigate_next_outlined, size: context.getDefaultSize() * 4),
                  ],
                ),
              ),
            ),
            const CustomDividerWidget()
          ],
        ),
      ),
    );
  }
}
