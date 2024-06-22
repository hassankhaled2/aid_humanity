import 'dart:io';

import 'package:aid_humanity/core/extensions/mediaquery_extension.dart';
import 'package:aid_humanity/core/utils/theme/app_color/app_color_light.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fancy_shimmer_image/fancy_shimmer_image.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UserSliverAppBar extends StatefulWidget {
  const UserSliverAppBar({
    super.key,
    required this.FullName,
    required this.photoUrl,
  });
  final String FullName;
  final String? photoUrl;
  @override
  State<UserSliverAppBar> createState() => _UserSliverAppBarState();
}

class _UserSliverAppBarState extends State<UserSliverAppBar> {
  File? select;

  List<QueryDocumentSnapshot> data = [];
  bool isloading = true;

  String Email = '';
  String Phone = '';
  String Address = '';
  // String displayName='';
  String? url;

  // SelectAndUploadImage()async {
  //
  //
  //  final reteurnimage= await ImagePicker().pickImage(source: ImageSource.gallery);
  //   select=File(reteurnimage!.path);
  //   var imageName=basename(reteurnimage.path);
  //   var refStorage =FirebaseStorage.instance.ref("UsersProfile/$imageName");
  //    refStorage.putFile(select!);
  //    url=await refStorage.getDownloadURL();
  //
  //  setState(() {
  //
  //  });
  // }

  String? image;
  Future<void> getImage() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    image = sharedPreferences.getString("userImage");
    // setState(() {
    //   imageUrl = url;
    // });
  }

  // final UserItemWidget  r;
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
      flexibleSpace: FlexibleSpaceBar(
        centerTitle: true,
        title: Text(
          widget.FullName,
          style: TextStyle(color: AppColorsLight.primaryColor),
        ),
        titlePadding: const EdgeInsets.only(left: 10, bottom: 10),
        background: ClipRRect(
          borderRadius: BorderRadius.only(
            bottomRight: Radius.circular(context.getDefaultSize() * 3),
          ),
          child: FancyShimmerImage(
            imageUrl: widget.photoUrl != null ? widget.photoUrl! : "",
            shimmerDuration:
                Duration(seconds: 2), // Adjust the shimmer duration as needed
            boxFit: BoxFit.fill, // Adjust the box fit as needed
            errorWidget: Image.asset(
                "assets/pics/circle_avatar.jpg"), // Placeholder widget to display when the image fails to load
            width: context.getDefaultSize() * 4,
            height: context.getDefaultSize() * 4,
            shimmerBaseColor:
                Colors.grey, // Adjust the shimmer base color as needed
            shimmerHighlightColor:
                Colors.white, // Adjust the shimmer highlight color as needed
          ),
          //url==null?  Image.network(widget.photoUrl):Image.network(url!,fit: BoxFit.fill,)
        ),
      ),
    );
  }
}
