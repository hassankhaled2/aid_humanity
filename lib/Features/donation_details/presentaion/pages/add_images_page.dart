/*import 'package:aid_humanity/Features/donation_details/widgets/items/add_images_Item.dart';

import 'package:aid_humanity/core/widgets/defualt_app_bar_widget.dart';
import 'package:flutter/material.dart';

class AddImagesPage extends StatelessWidget {
  const AddImagesPage({super.key});

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      appBar: _buildAppBar(context),
      body: _buildBody(),
    );
  }
  AppBar _buildAppBar(BuildContext context) => getDefaultAppBarWidget(
        context: context,
        title: "Add Images",
        color: Colors.black,
      );

  Widget _buildBody() => const AddImagesItem();
}*/
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:tflite_v2/tflite_v2.dart';

class TestModel extends StatefulWidget {
  const TestModel({super.key});

  @override
  State<TestModel> createState() => _TestModelState();
}

class _TestModelState extends State<TestModel> {
  bool _loading = true;
  late File _image;
  final picker = ImagePicker();
  late List _output = List.empty();

  @override
  void initState() {
    super.initState();
    loadModel().then((value) {
      setState(() {});
    });
  }

  @override
  void dispose() {
    super.dispose();
    Tflite.close();
  }

  Future<void> loadModel() async {
    await Tflite.loadModel(model: "assets/ai_model/New_CNN.tflite", labels: "assets/ai_model/lables.txt",);
  }

  pickGallery() async {
    // ignore: body_might_complete_normally_catch_error
    var image = await picker.pickImage(source: ImageSource.gallery).catchError((e) {
      // ignore: avoid_print
      print(e.toString());
    });
    if (image == null) return null;
    setState(() {
      _image = File(image.path);
    });
    classifyImage(_image);
  }

  pickCamera() async {
    // ignore: body_might_complete_normally_catch_error
    var image = await picker.pickImage(source: ImageSource.camera).catchError((e) {
      // ignore: avoid_print
      print(e.toString());
    });
    if (image == null) return null;
    setState(() {
      _image = File(image.path);
    });
    classifyImage(_image);
  }

  classifyImage(File image) async {
    var output = await Tflite.runModelOnImage(
      numResults: 2,
      path: image.path,
    );
    setState(() {
      _output = output!;
      print(_output);

      _loading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            _loading == true ? Image.network("https://static.thenounproject.com/png/4974686-200.png") : Image.file(_image, height: 300, width: 300),
            const SizedBox(
              height: 10,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                    onPressed: () async {
                      await pickGallery();

                      // ignore: avoid_print
                    },
                    child: const Text("pick image")),
                const SizedBox(
                  width: 30,
                ),
                ElevatedButton(
                    onPressed: () async {
                      await pickCamera();

                      // ignore: avoid_print
                    },
                    child: const Text("take image")),
              ],
            ),
            const SizedBox(
              height: 30,
            ),
            _output.isEmpty ? const SizedBox() : const Text("Result", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
            const SizedBox(
              height: 10,
            ),
            _output.isEmpty
                ? const SizedBox()
                : SizedBox(
                    height: 200,
                    width: 200,
                    child: ListView.builder(
                        itemCount: _output.length,
                        itemBuilder: (context, index) {
                          return Text(
                            "${index + 1} - " + _output[index]["label"].toString().substring(1),
                            style: const TextStyle(fontSize: 20),
                          );
                        }),
                  )
          ],
        ),
      ),
    );
  }
}
