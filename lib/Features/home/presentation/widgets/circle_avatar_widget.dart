import 'dart:io';

import 'package:aid_humanity/core/extensions/mediaquery_extension.dart';
import 'package:aid_humanity/core/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class CircleAvatarWidget extends StatefulWidget {
  const CircleAvatarWidget({super.key});

  @override
  State<CircleAvatarWidget> createState() => _CircleAvatarWidgetState();
}

class _CircleAvatarWidgetState extends State<CircleAvatarWidget> {
  File? _imageFile;
  Future<void> _pickImage() async {
    final pickedFile =
        await ImagePicker().pickImage(source: ImageSource.gallery);
    setState(() {
      _imageFile = pickedFile != null ? File(pickedFile.path) : null;
    });
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Stack(
        clipBehavior: Clip.none, // Clip overflowing widgets
        children: [
          CircleAvatar(
            backgroundImage: _imageFile != null
                ? (_imageFile as ImageProvider)
                : const NetworkImage(
                    "https://cdn3.vectorstock.com/i/1000x1000/04/72/user-icon-vector-19240472.jpg"),
            radius: 30.0,
          ),
          Positioned(
            right: -2.0, // Adjust positioning as needed
            bottom: -2.0, // Adjust positioning as needed
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
                onPressed: _pickImage,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
