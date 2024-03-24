import 'dart:io';

import 'package:aid_humanity/core/extensions/mediaquery_extension.dart';
import 'package:aid_humanity/core/utils/constants.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart';
class CircleAvatarWidget extends StatefulWidget {
  const CircleAvatarWidget({super.key});

  @override
  State<CircleAvatarWidget> createState() => _CircleAvatarWidgetState();
}

class _CircleAvatarWidgetState extends State<CircleAvatarWidget> {
  File?select;
  String? url;
  SelectAndUploadImage()async {


    final reteurnimage= await ImagePicker().pickImage(source: ImageSource.gallery);
    select=File(reteurnimage!.path);
    var imageName=basename(reteurnimage.path);
    var refStorage =FirebaseStorage.instance.ref(imageName);
    refStorage.putFile(select!);
    url=await refStorage.getDownloadURL();

    setState(() {

    });
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Stack(
          clipBehavior: Clip.none, // Clip overflowing widgets
          children: [
            CircleAvatar(

              radius: 50.0,
              child: url == null
                  ? Text('')
                  : ClipOval(child: Image.network(url!, fit: BoxFit.fill)),
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
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
