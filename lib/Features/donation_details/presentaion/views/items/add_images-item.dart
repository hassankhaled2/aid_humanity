import 'dart:io';
import 'package:aid_humanity/Features/donation_details/presentaion/views/pages/donation_form_page.dart';
import 'package:aid_humanity/core/extensions/mediaquery_extension.dart';
import 'package:aid_humanity/core/utils/constants.dart';
import 'package:aid_humanity/core/widgets/custom_button_widget.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class AddImagesItem extends StatefulWidget {
  const AddImagesItem({super.key});

  @override
  State<AddImagesItem> createState() => _AddImagesItemState();
}

class _AddImagesItemState extends State<AddImagesItem> {
  bool _loading = true;
  final picker = ImagePicker();
  late List _output = List.empty();
  List<XFile> imageFileList = [];
  List<XFile>? galleryImages;


  void selectImages() async {
    final List<XFile>? selectedImages = await picker.pickMultiImage();
    if (selectedImages!.isNotEmpty) {
      imageFileList!.addAll(selectedImages);
    }
    setState(() {galleryImages = imageFileList;});
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }
  @override
  void deleteImage(int index) {
    setState(() {
      imageFileList!.removeAt(index);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          galleryImages == null
          ? Container(height:context.getHight()/1.4,child: Center(child: Text('No images selected'))):
          Expanded(
              child: Padding(
            padding: EdgeInsets.all(
              context.getDefaultSize() * 2,
            ),
            child: GridView.builder(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3,crossAxisSpacing: 8.0, // Add horizontal spacing
                  mainAxisSpacing: 8.0, // Add vertical spacing
                  childAspectRatio: 1.0,),
              itemCount: imageFileList!.length,
              itemBuilder: (BuildContext context, int index) {
                return Stack(
                  children: [
                    Image.file(
                      File(imageFileList[index].path),
                      fit: BoxFit.cover,
                    ),
                    Positioned(
                      top: -3,
                      right: 9,
                      child: GestureDetector(
                        onTap: () => deleteImage(index),
                        child: Icon(
                          Icons.cancel,
                          color: kPrimaryColor,
                        ),
                      ),
                    ),
                  ],
                );
              },
            ),
          )),
          const SizedBox(
            height: 20.0,
          ),

          Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Padding(
                  padding: EdgeInsets.all(context.getDefaultSize() * 1.5),
                  child: GestureDetector(
                    child: CustomButtonWidget(
                        height: 4,
                        width: 18,
                        title: "Pick images",
                        fontSize: 2),
                    onTap: selectImages,
                  )),
              Padding(
                padding: EdgeInsets.only(
                    top: context.getDefaultSize() * 1.5,
                    bottom: context.getDefaultSize() * 1.5,
                    right: context.getDefaultSize()),
                child: GestureDetector(
                  child: CustomButtonWidget(
                      height: 4, width: 18, title: "Submit", fontSize: 2),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => (const DonationFormPage())),
                    );
                  },
                ),
              ),
            ],
          )
        ],
      )),
    );
  }
}
