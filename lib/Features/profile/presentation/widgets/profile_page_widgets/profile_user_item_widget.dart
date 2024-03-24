import 'package:aid_humanity/core/extensions/mediaquery_extension.dart';
import 'package:aid_humanity/core/utils/theme/app_color/app_color_light.dart';
import 'package:aid_humanity/core/widgets/custom_divider_widget.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';

import '../../pages/user_info_page.dart';
// اللى برا
class UserItemWidget extends StatefulWidget {
  const UserItemWidget({super.key,});



  @override
  State<UserItemWidget> createState() => _UserItemWidgetState();
}

class _UserItemWidgetState extends State<UserItemWidget> {
  List<QueryDocumentSnapshot>data=[];
  bool isloading=true;

   String imageUrl='fgfg';
  @override
  void initState()  {
    super.initState();
    // Retrieve image URL on initialization
     getImage();
  }

  Future<void> getImage() async {
     final imageRef = FirebaseStorage.instance.ref().child('1000127182.jpg');
    final url = await imageRef.getDownloadURL();
    setState(() {
      imageUrl = url;
    });
  }
  @override
  Widget build(BuildContext context) {


   return  FutureBuilder(
       future:  FirebaseFirestore.instance.collection("UsersAuth").where("id",isEqualTo:FirebaseAuth.instance.currentUser!.uid ).get(), // Call getData() to fetch data
    builder: (context, snapshot) {
      if (snapshot.connectionState == ConnectionState.waiting) {
        return const Center(child: CircularProgressIndicator());
      } else if (snapshot.hasError) {
        // Handle errors
        return Text('Error: ${snapshot.error}');
      }else
      {
        var docs = snapshot.data!.docs;
        if (docs.isEmpty) {
          return const Text("No user data found"); ///  handle this
        }
        // Accessing single QueryDocumentSnapshot and then using .data() getting its map.
        ///asking
        final user = docs[0].data();
        final fullName =user["Full Name"];
        final Email =user["Email"];
        final Address =user["Address"];
        final Phone =user["Phone"];

      return  InkWell(
          onTap:()
          {
            Navigator.push(context, MaterialPageRoute(builder: (context) =>  UserInfoPage(fullName:fullName, email: Email, phone: Phone, address: Address, photoUrl:imageUrl, )));

          },
          child: SizedBox(
            width: double.infinity,
            height: context.getDefaultSize() * 6,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const CustomDividerWidget(),
                Expanded(
                  child: Padding(
                    padding: EdgeInsets.symmetric(
                        horizontal: context.getDefaultSize() * 1.5),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        CircleAvatar(
                          backgroundImage: NetworkImage(
                              imageUrl
                          ),
                          radius: context.getDefaultSize() * 2,
                        ),
                        SizedBox(
                          width: context.getDefaultSize() * 1.2,
                        ),
                        Expanded(
                            child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    fullName,
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
                                    " ${user["Phone"]}",
                                    style: TextStyle(
                                        color: AppColorsLight.primaryColor,
                                        fontSize: context.getDefaultSize() *
                                            1.4,
                                        overflow: TextOverflow.ellipsis),
                                  ),
                                ])),
                        const Spacer(),
                        Icon(Icons.navigate_next_outlined, size: context
                            .getDefaultSize() * 4),
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
    },

   );

  }
}
// StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
// stream: FirebaseFirestore.instance.collection('UsersAuth').snapshots(),
// builder: (_, snapshot) {
// if (snapshot.hasError) return Text('Error = ${snapshot.error}');
//
// if (snapshot.hasData) {
// final docs = snapshot.data!.docs;
// return ListView.builder(
// scrollDirection: Axis.horizontal,
// itemCount: docs.length, itemBuilder: (_, i) {
// final data = docs[i].data();
//
// },
// );
// }
//
// return Center(child: CircularProgressIndicator());
// },
// );