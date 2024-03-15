import 'package:aid_humanity/core/extensions/mediaquery_extension.dart';
import 'package:aid_humanity/core/utils/theme/app_color/app_color_light.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class UserSliverAppBar extends StatefulWidget {
  const UserSliverAppBar({super.key});
  // final String fullName ;

  @override
  State<UserSliverAppBar> createState() => _UserSliverAppBarState();
}

class _UserSliverAppBarState extends State<UserSliverAppBar> {

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
    setState(() {

    });
  }
  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      titleTextStyle: const TextStyle(color: Colors.black),
      pinned: true,
      centerTitle: true,
      floating: true,
      expandedHeight: context.getHight() * 0.35,
      backgroundColor: Colors.transparent,
      iconTheme: const IconThemeData(color: AppColorsLight.primaryColor),
      actions: [
        IconButton(onPressed: () {}, icon: const Icon(Icons.camera_alt_rounded)),
      ],
      flexibleSpace: FlexibleSpaceBar(
        centerTitle: true,
        title:  Text(
         FullName,
          style: TextStyle(color: AppColorsLight.primaryColor),
        ),
        titlePadding: const EdgeInsets.only(left: 10, bottom: 10),
        background: ClipRRect(
            borderRadius: BorderRadius.only(
              bottomRight: Radius.circular(context.getDefaultSize() * 3),
            ),
            child:  Image.network("",
              fit: BoxFit.fill, errorBuilder: (context, error, stackTrace) =>  const Center(child: CircularProgressIndicator(color: Colors.orangeAccent,)),),
      ),
      ),
    );
  }
}
