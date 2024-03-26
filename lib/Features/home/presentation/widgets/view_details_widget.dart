import 'dart:io';
import 'dart:typed_data';
import 'dart:ui';

import 'package:aid_humanity/Features/home/presentation/bloc/home_bloc.dart';
import 'package:aid_humanity/core/widgets/BottomNavigation.dart';
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:aid_humanity/core/constants/constants.dart';
import 'package:aid_humanity/core/entities/request_entity.dart';
import 'package:aid_humanity/core/extensions/mediaquery_extension.dart';
import 'package:aid_humanity/core/widgets/custom_button_widget.dart';
import 'package:aid_humanity/core/widgets/defualt_app_bar_widget.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:intl/intl.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:url_launcher/url_launcher.dart';

class ViewDetailsWidget extends StatefulWidget {
  final RequestEntity requestEntity;
  const ViewDetailsWidget({
    super.key,
    required this.requestEntity,
  });

  @override
  State<ViewDetailsWidget> createState() => _ViewDetailsWidgetState();
}

class _ViewDetailsWidgetState extends State<ViewDetailsWidget> {
  late GoogleMapController googleMapController;
  bool isQrCodeScanned = false;
  final GlobalKey globalKey = GlobalKey();
  dynamic externalDir = '/storage/emulated/0/Download';
  Set<Marker> markers = {};

  _captureAndSaveQrCode() async {
    try {
      //ask for permission
      await Permission.manageExternalStorage.request();
      var status = await Permission.manageExternalStorage.status;
      if (status.isDenied) {
        // We didn't ask for permission yet or the permission has been denied   before but not permanently.
        return;
      }

// You can can also directly ask the permission about its status.
      if (await Permission.storage.isRestricted) {
        // The OS restricts access, for example because of parental controls.
        return;
      }
      if (status.isGranted) {
//here you add the code to store the file

        RenderRepaintBoundary boundary = globalKey.currentContext!.findRenderObject() as RenderRepaintBoundary;
        var image = await boundary.toImage(pixelRatio: 3.0);
        final whitepaint = Paint()..color = Colors.white;
        final recorder = PictureRecorder();
        final canvas = Canvas(recorder, Rect.fromLTWH(0, 0, image.width.toDouble(), image.height.toDouble()));
        canvas.drawRect(Rect.fromLTWH(0, 0, image.width.toDouble(), image.height.toDouble()), whitepaint);
        canvas.drawImage(image, Offset.zero, Paint());
        final picture = recorder.endRecording();
        final img = await picture.toImage(image.width, image.height);
        ByteData? bytedate = await img.toByteData(format: ImageByteFormat.png);
        Uint8List pngBytes = bytedate!.buffer.asUint8List();
        String fileName = 'qr code ${DateTime.now().millisecondsSinceEpoch}';
        final file = await File('$externalDir/$fileName.png').create();
        await file.writeAsBytes(pngBytes);
        if (!mounted) return;
        print("/**********************************");
        Navigator.pop(context);
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          behavior: SnackBarBehavior.floating,
          backgroundColor: Colors.green,
          content: Text('QR code Exported successfully'),
        ));
      }
    } catch (e) {
      print(e);
    }
  }

  @override
  void initState() {
    FirebaseFirestore.instance.collection('request').doc(widget.requestEntity.id).snapshots().listen((event) {
      if (event.data() != null) {
        setState(() {
          isQrCodeScanned = event.data()!['qrScanned'];
          if (isQrCodeScanned) {
            Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => const BottomNavigation()));
            AwesomeDialog(
              context: context,
              dialogType: DialogType.success,
              animType: AnimType.rightSlide,
              title: 'Done',
              desc: 'Thank you for spreading humanity',
              buttonsTextStyle: const TextStyle(color: Colors.black),
              showCloseIcon: true,
            ).show();
          }
        });
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0XFFE9EAEE),
      appBar: getDefaultAppBarWidget(context: context, title: "Donation Details", backgroundColor: kPrimaryColor, iconColor: Colors.white),
      body: Column(
        children: [
          Expanded(
            child: GoogleMap(
              markers: {const Marker(markerId: MarkerId("1"), position: LatLng(5, 5))},
              mapType: MapType.normal,
              onMapCreated: (GoogleMapController controller) {
                googleMapController = controller;
              },
              initialCameraPosition: const CameraPosition(
                target: LatLng(5, 5),
                zoom: 14,
              ),
            ),
          ),
          Container(
            height: context.getHight() / 1.8,
            width: context.getWidth(),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(
                    context.getDefaultSize() * 3,
                  ),
                  topRight: Radius.circular(
                    context.getDefaultSize() * 3,
                  )),
            ),
            child: Column(mainAxisAlignment: MainAxisAlignment.start, crossAxisAlignment: CrossAxisAlignment.start, children: [
              Expanded(
                child: Column(
                  children: [
                    Padding(
                      padding: EdgeInsets.only(
                        top: context.getDefaultSize() * 2,
                        left: context.getDefaultSize() * 2,
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Text(
                                "Donor's name:",
                                style: TextStyle(color: kPrimaryColor, fontSize: context.getDefaultSize() * 1.8, fontWeight: FontWeight.bold),
                              ),
                              SizedBox(
                                width: context.getDefaultSize(),
                              ),
                              SizedBox(
                                height: context.getDefaultSize() * 3,
                                width: context.getDefaultSize() * 14.5,
                                child: ListView(
                                  shrinkWrap: true,
                                  scrollDirection: Axis.horizontal,
                                  children: [
                                    Text(
                                      "Menna Ahmed",
                                      style: TextStyle(fontSize: context.getDefaultSize() * 2, color: Colors.black, fontWeight: FontWeight.bold),
                                    ),
                                  ],
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.all(context.getDefaultSize()),
                                child: Container(
                                  width: context.getDefaultSize() * 10,
                                  decoration: BoxDecoration(
                                    color: kSecondryColor,
                                    borderRadius: BorderRadius.circular(
                                      context.getDefaultSize() * 2,
                                    ),
                                  ),
                                  child: Center(
                                    child: Text(
                                      "2 min ago",
                                      style: TextStyle(fontSize: context.getDefaultSize() * 1.5, color: Colors.white, fontWeight: FontWeight.bold),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                          Row(
                            children: [
                              Text(
                                "Location :",
                                style: TextStyle(color: kPrimaryColor, fontSize: context.getDefaultSize() * 1.6, fontWeight: FontWeight.bold),
                              ),
                              SizedBox(
                                width: context.getDefaultSize(),
                              ),
                              SizedBox(
                                height: context.getDefaultSize() * 3,
                                width: context.getDefaultSize() * 25,
                                child: ListView(
                                  shrinkWrap: true,
                                  scrollDirection: Axis.horizontal,
                                  children: [
                                    Center(
                                      child: Text(
                                        "Cairo, El-Shrouk city, Dar Masr,-----------",
                                        style: TextStyle(
                                          fontSize: context.getDefaultSize() * 1.6,
                                          color: Colors.black,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                          Row(
                            children: [
                              Text(
                                "Phone no.:",
                                style: TextStyle(color: kPrimaryColor, fontSize: context.getDefaultSize() * 1.6, fontWeight: FontWeight.bold),
                              ),
                              SizedBox(
                                width: context.getDefaultSize(),
                              ),
                              Text(
                                "01002736659",
                                style: TextStyle(
                                  fontSize: context.getDefaultSize() * 1.6,
                                  color: Colors.black,
                                ),
                              ),
                            ],
                          )
                        ],
                      ),
                    ),
                    SizedBox(
                      height: context.getDefaultSize() * 2,
                    ),
                    Expanded(
                      child: ListView(
                        scrollDirection: Axis.vertical,
                        children: [
                          Row(
                            children: [
                              addressText(context, "quantity"),
                              SizedBox(
                                width: context.getDefaultSize() * 14,
                              ),
                              addressText(context, "Pickup day"),
                            ],
                          ),
                          Row(
                            children: [
                              formTextField(context, widget.requestEntity.numberOfItems.toString()),
                              SizedBox(
                                width: context.getDefaultSize() * 4,
                              ),
                              formTextField(context, DateFormat('yyyy-MM-dd').format(widget.requestEntity.time)),
                            ],
                          ),
                          addressText(context, "Items"),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: SizedBox(
                              height: context.getDefaultSize() * 20,
                              child: ListView.builder(scrollDirection: Axis.horizontal, itemCount: widget.requestEntity.items!.length, itemBuilder: (_, index) => photoWidget(context, widget.requestEntity.items![index].image, index)),
                            ),
                          ),
                          SizedBox(
                            height: context.getDefaultSize(),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.all(context.getDefaultSize() * 2),
                child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
                  GestureDetector(
                      onTap: () {
                        widget.requestEntity.status == "Pending"
                            ? BlocProvider.of<HomeBloc>(context).add(AcceptRequestEvent(requestId: widget.requestEntity.id!, deliveryId: FirebaseAuth.instance.currentUser!.uid, status: "inProgress"))
                            : showModalBottomSheet(
                                context: context,
                                builder: (_) {
                                  return SizedBox(
                                    height: context.getHight() * 0.4,
                                    width: double.infinity,
                                    child: Column(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: [
                                        RepaintBoundary(
                                          key: globalKey,
                                          child: QrImageView(
                                            data: widget.requestEntity.id!,
                                            version: QrVersions.auto,
                                            size: 200.0,
                                          ),
                                        ),
                                        Text("shipment id : ${widget.requestEntity.id!}"),
                                        ElevatedButton(
                                            onPressed: () {
                                              _captureAndSaveQrCode();
                                            },
                                            child: const Padding(
                                              padding: EdgeInsets.all(10.0),
                                              child: Text(
                                                "export",
                                                style: TextStyle(color: Colors.white),
                                              ),
                                            ))
                                      ],
                                    ),
                                  );
                                });
                      },
                      child: BlocConsumer<HomeBloc, HomeState>(
                        listener: (context, state) {
                          if (state is AcceptRequsetSuccessState) {
                            ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("Request Accepted Successfuly")));
                            Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (_) => const BottomNavigation()), (route) => false);
                          }
                        },
                        builder: (context, state) {
                          if (state is AcceptRequsetLoadingState) {
                            return const Center(
                              child: CircularProgressIndicator(),
                            );
                          }
                          return widget.requestEntity.status == "Pending" ? CustomButtonWidget(height: 4, width: 18, title: "Accept", fontSize: 2) : CustomButtonWidget(height: 4, width: 18, title: "Done", fontSize: 2);
                        },
                      )),
                  GestureDetector(
                    onTap: () async {
                      final Uri url = Uri(
                        scheme: 'tel',
                        path: "0100 273 6659",
                      );
                      if (await canLaunchUrl(url)) {
                        await launchUrl(url);
                      } else {
                        // ignore: avoid_print
                        print("cannot lunch this url");
                      }
                    },
                    child: CustomButtonWidget(height: 4, width: 18, title: "CALL NOW", fontSize: 1.8),
                  ),
                ]),
              ),
            ]),
          )
        ],
      ),
    );
  }

  Padding addressText(BuildContext context, String title) {
    return Padding(
      padding: EdgeInsets.only(
        left: context.getDefaultSize() * 2,
      ),
      child: Text(
        title,
        style: TextStyle(color: kPrimaryColor, fontSize: context.getDefaultSize() * 1.5, fontWeight: FontWeight.bold),
      ),
    );
  }

  Padding formTextField(BuildContext context, String hint, {TextEditingController? textEditingController, VoidCallback? onTap}) {
    return Padding(
      padding: EdgeInsets.only(right: context.getDefaultSize() * 2, left: context.getDefaultSize() * 2, bottom: context.getDefaultSize() * 1.5),
      child: SizedBox(
        width: context.getWidth() / 3,
        child: TextField(
          readOnly: true,
          onTap: onTap,
          controller: textEditingController,
          style: TextStyle(
            color: Colors.black,
            fontSize: context.getDefaultSize() * 2,
          ),
          autocorrect: true,
          cursorColor: kPrimaryColor,
          scribbleEnabled: true,
          decoration: InputDecoration(
              hintText: hint,
              hintStyle: TextStyle(color: Colors.black, fontSize: context.getDefaultSize() * 1.5),
              focusedBorder: UnderlineInputBorder(
                borderSide: BorderSide(color: kPrimaryColor),
              ),
              enabledBorder: UnderlineInputBorder(
                borderSide: BorderSide(color: kPrimaryColor),
              )),
        ),
      ),
    );
  }

  Widget photoWidget(BuildContext context, String photo, int index) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        children: [
          Text(widget.requestEntity.items![index].type),
          Stack(
            alignment: Alignment.center,
            children: [
              Container(
                height: context.getDefaultSize() * 15,
                width: context.getDefaultSize() * 15,
                decoration: BoxDecoration(image: DecorationImage(image: NetworkImage(photo), fit: BoxFit.contain)),
              ),
              Container(
                height: context.getDefaultSize() * 15,
                width: context.getDefaultSize() * 15,
                color: Colors.grey.withOpacity(0.4),
                child: Center(
                  child: Text(
                    widget.requestEntity.items![index].quantity.toString(),
                    style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: context.getDefaultSize() * 3),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
