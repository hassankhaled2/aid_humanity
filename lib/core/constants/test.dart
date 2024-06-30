import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart';
SelectAndUploadImage({required String url})async {
  File?select;

  final reteurnimage= await ImagePicker().pickImage(source: ImageSource.gallery);
  select=File(reteurnimage!.path);
  var imageName=basename(reteurnimage.path);
  var refStorage =FirebaseStorage.instance.ref("UsersProfile/$imageName");
  refStorage.putFile(select);
  url=await refStorage.getDownloadURL();


}