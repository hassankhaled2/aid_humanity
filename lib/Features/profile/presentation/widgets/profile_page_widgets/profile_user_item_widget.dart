import 'package:aid_humanity/core/extensions/mediaquery_extension.dart';
import 'package:aid_humanity/core/utils/theme/app_color/app_color_light.dart';
import 'package:aid_humanity/core/widgets/custom_divider_widget.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fancy_shimmer_image/fancy_shimmer_image.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

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
  var fullName ;
  var phone;
  var email ;
  var address;
  bool isSignin=false;

  @override
  void initState()  {
    super.initState();

   getImage();
    // getPref();
  }

String ?image;
  Future<void> getImage() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    image=sharedPreferences.getString("userImage");
    // setState(() {
    //   imageUrl = url;
    // });
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
        final fullName =user["fullName"];
        final Email =user["Email"];
        final street =user["street"];
        final region =user["region"];
        final country =user["country"];
        final city =user["city"];
        final Phone =user["Phone"];
        final flatNumber =user["flatNumber"];
        final floorNumber =user["floorNumber"];
        return  InkWell(
          onTap:()
          {
            Navigator.push(context, MaterialPageRoute(builder: (context) =>  UserInfoPage(fullName:fullName, email: Email, phone: Phone, street: street, photoUrl:image!= null?image!:"assets/pics/circle_avatar.jpg", region:region, city: city ,country: country, flatNumber: flatNumber,floorNumber: floorNumber,)));

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
                        ClipOval(
                          child: FancyShimmerImage(
                            //when image is null go to errorWidget to display another image
                            imageUrl: image!= null?image!:"",
                            shimmerDuration: Duration(seconds: 2), // Adjust the shimmer duration as needed
                            boxFit: BoxFit.fill, // Adjust the box fit as needed
                            errorWidget: Image.asset("assets/pics/circle_avatar.jpg"), // Placeholder widget to display when the image fails to load
                            width: context.getDefaultSize() * 4,
                            height: context.getDefaultSize() * 4,
                            shimmerBaseColor: Colors.grey, // Adjust the shimmer base color as needed
                            shimmerHighlightColor: Colors.white, // Adjust the shimmer highlight color as needed
                          ),
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
                                  // isSignin?Text(
                                  //   fullName,
                                  //   style: TextStyle(
                                  //     fontWeight: FontWeight.bold,
                                  //     fontSize: context.getDefaultSize() * 1.8,
                                  //     overflow: TextOverflow.ellipsis,
                                  //   ),
                                  // ):Text(''),
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