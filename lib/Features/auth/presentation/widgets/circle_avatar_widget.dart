import 'dart:io';
import 'package:aid_humanity/Features/onBoarding/onboarding.dart';
import 'package:aid_humanity/core/extensions/mediaquery_extension.dart';
import 'package:aid_humanity/core/extensions/translation_extension.dart';
import 'package:aid_humanity/core/utils/constants.dart';
import 'package:fancy_shimmer_image/fancy_shimmer_image.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CircleAvatarWidget extends StatefulWidget {
  const CircleAvatarWidget({
    super.key,
  });

  @override
  State<CircleAvatarWidget> createState() => _CircleAvatarWidgetState();
}

class _CircleAvatarWidgetState extends State<CircleAvatarWidget> {
  File? select;
  String? url;
  SelectAndUploadImage() async {
    final reteurnimage =
        await ImagePicker().pickImage(source: ImageSource.gallery);
    select = File(reteurnimage!.path);
    var imageName = basename(reteurnimage.path);
    // var refStorage =FirebaseStorage.instance.ref("usersProfile/$imageName");
    var refStorage =FirebaseStorage.instance.ref("usersImages").child(imageName);
    await refStorage.putFile(select!);

    url = await refStorage.getDownloadURL();
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    sharedPreferences.setString("userImage", url!);
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Column(
          // crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(context.translate("Add_Your_Image")),
            Center(
              child: Stack(
                // clipBehavior: Clip.none, // Clip overflowing widgets
                children: [
                  CircleAvatar(

                    radius:context.getDefaultSize() * 7 ,
                    child: url == null
                        ? Text('')
                        :    ClipOval(
                      child: FancyShimmerImage(
                        imageUrl: url!,
                        shimmerDuration: Duration(seconds: 2),
                        boxFit: BoxFit.fill,
                        width: context.getDefaultSize() * 20,
                        height: context.getDefaultSize() * 20,
                        shimmerBaseColor: Colors.grey,
                        shimmerHighlightColor: Colors.white,
                      ),
                    ),
                  ),
                  Positioned(
                    right: context.getDefaultSize() * 0.2, // Adjust positioning as needed
                    bottom:context.getDefaultSize() * 0, // Adjust positioning as needed
                    child: Container(
                      height: context.getDefaultSize() * 3.5,
                      width: context.getDefaultSize() * 3.5,
                      decoration: BoxDecoration(
                        color: kPrimaryColor, // Change color as desired
                        shape: BoxShape.circle,
                      ),
                      child: IconButton(
                        icon: Icon(
                          Icons.add,
                          size: context.getDefaultSize() * 2,
                          color: Colors.white,
                        ),
                        onPressed:()
                        {
                          SelectAndUploadImage();
                          // ProfilePage(k: url!);

                        },
                      ),
                    ),
                  ),
                  // ElevatedButton(onPressed: ()
                  // {
                  //   Navigator.of(context).push(MaterialPageRoute(builder: (context)
                  //   {
                  //     return ProfilePage(k: url!,);
                  //   }));
                  // }, child:Text("nh")
                  // )
                  // ProfilePage(k:url!),
                ],
              ),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).push(
                  MaterialPageRoute(builder: (context) => OnBoarding()),
                );
                // if (select != null) { // Check if an image is selected
                //   Navigator.of(context).push(
                //     MaterialPageRoute(builder: (context) => OnBoarding()),
                //   );
                // } else {
                //   // Handle the case where no image is selected (optional)
                //   ScaffoldMessenger.of(context).showSnackBar(
                //     SnackBar(
                //       duration: Duration(seconds: 4),
                //       content: Text('Please select an image to Submit'),
                //     ),
                //   );
                // }
              },
              child: Text(context.translate("Skip")),
            ),
          ],
        )
    );
  }
}
