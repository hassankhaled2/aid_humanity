// import 'dart:io';
//
// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:image_picker/image_picker.dart';
// import 'package:firebase_storage/firebase_storage.dart';
// import 'package:path/path.dart';
//
// // Define states
// abstract class ImageState {}
//
// class ImageInitial extends ImageState {}
//
// class ImageUploaded extends ImageState {
//   final String imageUrl;
//
//   ImageUploaded(this.imageUrl);
// }
//
// class ImageUploadFailed extends ImageState {}
//
// // Define events
// // abstract class ImageEvent {}
// //
// // class SelectAndUploadImageEvent extends ImageEvent {}
//
// // Define cubit
// class ImageCubit extends Cubit<ImageState> {
//   ImageCubit() : super(ImageInitial());
//
//   final ImagePicker _imagePicker = ImagePicker();
//
//   Future<void> selectAndUploadImage() async {
//     try {
//       final pickedImage = await _imagePicker.pickImage(source: ImageSource.gallery);
//       if (pickedImage != null) {
//         final selectedImageFile = File(pickedImage.path);
//         var imageName = basename(pickedImage.path);
//         var refStorage = FirebaseStorage.instance.ref("usersImages").child(imageName);
//         await refStorage.putFile(selectedImageFile);
//         var downloadUrl = await refStorage.getDownloadURL();
//         emit(ImageUploaded(downloadUrl));
//       } else {
//         throw Exception('No image selected');
//       }
//     } catch (e) {
//       emit(ImageUploadFailed());
//     }
//   }
// }
//
// // Usage
// class YourWidget extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return BlocProvider(
//       create: (context) => ImageCubit(),
//       child: YourChildWidget(),
//     );
//   }
// }
//
// class YourChildWidget extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     final imageCubit = BlocProvider.of<ImageCubit>(context);
//
//     return Scaffold(
//       body: Center(
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             ElevatedButton(
//               onPressed: () {
//                 imageCubit.selectAndUploadImage();
//               },
//               child: Text('Select and Upload Image'),
//             ),
//             BlocBuilder<ImageCubit, ImageState>(
//               builder: (context, state) {
//                 if (state is ImageUploaded) {
//                   return Image.network(
//                     state.imageUrl,
//                     height: 200,
//                     width: 200,
//                   );
//                 } else if (state is ImageUploadFailed) {
//                   return Text('Image upload failed');
//                 } else {
//                   return SizedBox();
//                 }
//               },
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
//  class TestWidget extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     final imageCubit = BlocProvider.of<ImageCubit>(context);
//    return Scaffold
//      (
//      body: Column(
//        children:
//        [
//          ElevatedButton(onPressed: ()
//          {
//            imageCubit.selectAndUploadImage();
//          }, child: Text
//            (
//            "fdfdfdf"
//          )),
//          BlocBuilder<ImageCubit, ImageState>(
//            builder: (context, state) {
//              if (state is ImageUploaded) {
//                return Image.network(
//                  state.imageUrl,
//                  height: 200,
//                  width: 200,
//                );
//              } else if (state is ImageUploadFailed) {
//                return Text('Image upload failed');
//              } else {
//                return SizedBox();
//              }
//            },
//          ),
//        ],
//      ),
//    );
//   }
//
//  }