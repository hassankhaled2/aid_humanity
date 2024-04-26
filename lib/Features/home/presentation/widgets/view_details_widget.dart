import 'dart:io';
import 'dart:typed_data';
import 'dart:ui';

import 'package:aid_humanity/Features/home/presentation/bloc/home_bloc.dart';
import 'package:aid_humanity/core/extensions/translation_extension.dart';
import 'package:aid_humanity/core/widgets/BottomNavigationDelivery.dart';
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
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:intl/intl.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../../core/utils/theme/cubit/theme_cubit.dart';

class ViewDetailsWidget extends StatefulWidget {
  final RequestEntity requestEntity;
  late bool isDonor;
  ViewDetailsWidget(
      {super.key, required this.requestEntity, required this.isDonor});

  @override
  State<ViewDetailsWidget> createState() => _ViewDetailsWidgetState();
}

class _ViewDetailsWidgetState extends State<ViewDetailsWidget> {
  late GoogleMapController googleMapController;
  bool isQrCodeScanned = false;
  final GlobalKey globalKey = GlobalKey();
  dynamic externalDir = '/storage/emulated/0/Download';
  Set<Marker> markers = {};
  var currentTime = DateTime.now();
  var resultTime;
  Map<String, dynamic>? userDetails;
  bool isLoading = true;
  Position? position;

  Future<Map<String, dynamic>?> getUserDetailsByRequestId(
      String requestId) async {
    final firestore = FirebaseFirestore.instance;
    // Get the request document reference
    final userId = widget.requestEntity.userId;
    // Extract user ID from request data
    // Query userAuth collection with retrieved userId
    final userQuery =
        firestore.collection('UsersAuth').where('id', isEqualTo: userId);
    final userQuerySnap = await userQuery.get();
    // Check if user document exists (based on userId)
    if (userQuerySnap.docs.isEmpty) {
      return null;
    }
    // Assuming there's only one user document with the matching userId
    final userDoc = userQuerySnap.docs.first;
    final name = userDoc.data()['Full Name'];
    final phoneNumber = userDoc.data()['Phone'];
    final latitude = userDoc.data()['LAT'];
    final longitude = userDoc.data()['LNG'];

    // Return user details as a map
    return {
      'name': name,
      'phoneNumber': phoneNumber,
      'latitude': latitude,
      'longitude': longitude,
    };
  }

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

        RenderRepaintBoundary boundary = globalKey.currentContext!
            .findRenderObject() as RenderRepaintBoundary;
        var image = await boundary.toImage(pixelRatio: 3.0);
        final whitepaint = Paint()..color = Colors.white;
        final recorder = PictureRecorder();
        final canvas = Canvas(
            recorder,
            Rect.fromLTWH(
                0, 0, image.width.toDouble(), image.height.toDouble()));
        canvas.drawRect(
            Rect.fromLTWH(
                0, 0, image.width.toDouble(), image.height.toDouble()),
            whitepaint);
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
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          behavior: SnackBarBehavior.floating,
          backgroundColor: Colors.green,
          content: Text(context.translate('QR code Exported successfully')),
        ));
      }
    } catch (e) {
      print(e);
    }
  }

  @override
  void initState() {
    _fetchUserDetails();
    resultTime = DateTime.now().difference(widget.requestEntity.time);
    print(resultTime);
    FirebaseFirestore.instance
        .collection('request')
        .doc(widget.requestEntity.id)
        .snapshots()
        .listen((event) {
      if (event.data() != null) {
        setState(() async {
          isQrCodeScanned = event.data()!['qrScanned'];
          if (isQrCodeScanned) {
            AwesomeDialog(
              context: context,
              dialogType: DialogType.success,
              animType: AnimType.rightSlide,
              title: context.translate('Done'),
              desc: context.translate('Thank_you_for_spreading_humanity'),
              buttonsTextStyle: const TextStyle(color: Colors.black),
              showCloseIcon: true,
            ).show();
            await Future.delayed(Duration(seconds: 3));
            Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(
                    builder: (context) => const BottomNavigationDelivery()),
                (_) => false);
          }
        });
      }
    });
    super.initState();
  }

  Future<void> _fetchUserDetails() async {
    final details =
        await getUserDetailsByRequestId(widget.requestEntity.userId);
    setState(() {
      userDetails = details;
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0XFFE9EAEE),
      appBar: getDefaultAppBarWidget(
          context: context,
          title: context.translate("Donation_Details"),
          backgroundColor: kPrimaryColor,
          iconColor: Colors.white),
      body: Column(
        children: [
          Expanded(
            child: isLoading
                ? Center(
                    child: CircularProgressIndicator(
                      color: kPrimaryColor,
                      strokeWidth: 5,
                      value: 5,
                    ),
                  )
                : GoogleMap(
                    markers: {
                      Marker(
                          markerId: MarkerId("1"),
                          position: LatLng(userDetails?['latitude'],
                              userDetails?['longitude']))
                    },
                    mapType: MapType.normal,
                    onMapCreated: (GoogleMapController controller) {
                      googleMapController = controller;
                    },
                    initialCameraPosition: CameraPosition(
                      target: LatLng(
                          userDetails?['latitude'], userDetails?['longitude']),
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
            child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: Column(
                      children: [
                        Padding(
                          padding: EdgeInsets.only(
                            top: context.getDefaultSize() * 2,
                            left: BlocProvider.of<ThemeCubit>(context)
                                        .locale
                                        .languageCode ==
                                    "en"
                                ? context.getDefaultSize() * 2
                                : 0,
                            right: BlocProvider.of<ThemeCubit>(context)
                                        .locale
                                        .languageCode ==
                                    "ar"
                                ? context.getDefaultSize() * 2
                                : 0,
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  Text(
                                    context.translate("Donor_name_"),
                                    style: TextStyle(
                                        color: kPrimaryColor,
                                        fontSize:
                                            context.getDefaultSize() * 1.8,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  SizedBox(
                                    width: context.getDefaultSize(),
                                  ),
                                  SizedBox(
                                    height: context.getDefaultSize() * 3,
                                    width: context.getDefaultSize() * 16,
                                    child: ListView(
                                      shrinkWrap: true,
                                      scrollDirection: Axis.horizontal,
                                      children: [
                                        Text(
                                          userDetails?['name'] ??
                                              "Name not found",
                                          style: TextStyle(
                                              fontSize:
                                                  context.getDefaultSize() * 2,
                                              color: Colors.black,
                                              fontWeight: FontWeight.bold),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                              Row(
                                children: [
                                  Text(
                                    context.translate("Government"),
                                    style: TextStyle(
                                        color: kPrimaryColor,
                                        fontSize:
                                            context.getDefaultSize() * 1.6,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  SizedBox(
                                    width: context.getDefaultSize(),
                                  ),
                                  SizedBox(
                                    height: context.getDefaultSize() * 3,
                                    width: context.getDefaultSize() * 10,
                                    child: ListView(
                                      shrinkWrap: true,
                                      scrollDirection: Axis.horizontal,
                                      children: [
                                        Center(
                                          child: Text(
                                            widget.requestEntity
                                                .address["government"]
                                                .toString(),
                                            style: TextStyle(
                                              fontSize:
                                                  context.getDefaultSize() *
                                                      1.6,
                                              color: Colors.black,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Text(
                                    context.translate("City"),
                                    style: TextStyle(
                                        color: kPrimaryColor,
                                        fontSize:
                                            context.getDefaultSize() * 1.6,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  SizedBox(
                                    width: context.getDefaultSize(),
                                  ),
                                  SizedBox(
                                    height: context.getDefaultSize() * 3,
                                    width: context.getDefaultSize() * 10,
                                    child: ListView(
                                      shrinkWrap: true,
                                      scrollDirection: Axis.horizontal,
                                      children: [
                                        Center(
                                          child: Text(
                                            widget.requestEntity.address["city"]
                                                .toString(),
                                            style: TextStyle(
                                              fontSize:
                                                  context.getDefaultSize() *
                                                      1.6,
                                              color: Colors.black,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                              Row(children: [
                                Text(
                                  context.translate("Remaining_address"),
                                  style: TextStyle(
                                      color: kPrimaryColor,
                                      fontSize: context.getDefaultSize() * 1.6,
                                      fontWeight: FontWeight.bold),
                                ),
                                SizedBox(
                                  width: context.getDefaultSize(),
                                ),
                                SizedBox(
                                  height: context.getDefaultSize() * 3,
                                  width: context.getDefaultSize() * 10,
                                  child: ListView(
                                    shrinkWrap: true,
                                    scrollDirection: Axis.horizontal,
                                    children: [
                                      Center(
                                        child: Text(
                                          widget
                                              .requestEntity.address["location"]
                                              .toString(),
                                          style: TextStyle(
                                            fontSize:
                                                context.getDefaultSize() * 1.6,
                                            color: Colors.black,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ]),
                              Row(
                                children: [
                                  Text(
                                    context.translate("Phone_no_"),
                                    style: TextStyle(
                                        color: kPrimaryColor,
                                        fontSize:
                                            context.getDefaultSize() * 1.6,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  SizedBox(
                                    width: context.getDefaultSize(),
                                  ),
                                  Text(
                                    userDetails?['phoneNumber'] ??
                                        "Phone number not found",
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
                          child: Padding(
                            padding: EdgeInsets.only(
                              left: BlocProvider.of<ThemeCubit>(context)
                                          .locale
                                          .languageCode ==
                                      "en"
                                  ? context.getDefaultSize() / 2
                                  : 0,
                              right: BlocProvider.of<ThemeCubit>(context)
                                          .locale
                                          .languageCode ==
                                      "ar"
                                  ? context.getDefaultSize() * 1.5
                                  : 0,
                            ),
                            child: ListView(
                              scrollDirection: Axis.vertical,
                              children: [
                                Row(
                                  children: [
                                    addressText(
                                        context, context.translate("quantity")),
                                    SizedBox(
                                      width: context.getDefaultSize() * 16,
                                    ),
                                    addressText(context,
                                        context.translate("Pickup_day")),
                                  ],
                                ),
                                Row(
                                  children: [
                                    formTextField(
                                        context,
                                        widget.requestEntity.numberOfItems
                                            .toString()),
                                    SizedBox(
                                      width: context.getDefaultSize() * 4,
                                    ),
                                    formTextField(
                                        context,
                                        DateFormat('yyyy-MM-dd')
                                            .format(widget.requestEntity.time)),
                                  ],
                                ),
                                addressText(
                                    context, context.translate("Items")),
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: SizedBox(
                                    height: context.getDefaultSize() * 20,
                                    child: ListView.builder(
                                        scrollDirection: Axis.horizontal,
                                        itemCount:
                                            widget.requestEntity.items!.length,
                                        itemBuilder: (_, index) => photoWidget(
                                            context,
                                            widget.requestEntity.items![index]
                                                .image,
                                            index)),
                                  ),
                                ),
                                SizedBox(
                                  height: context.getDefaultSize(),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.all(context.getDefaultSize() * 2),
                    child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          GestureDetector(
                              onTap: () {
                                widget.requestEntity.status == "Pending"
                                    ? BlocProvider.of<HomeBloc>(context).add(
                                        AcceptRequestEvent(
                                            requestId: widget.requestEntity.id!,
                                            deliveryId: FirebaseAuth
                                                .instance.currentUser!.uid,
                                            status: "inProgress"))
                                    : showModalBottomSheet(
                                        context: context,
                                        builder: (_) {
                                          return SizedBox(
                                            height: context.getHight() * 0.4,
                                            width: double.infinity,
                                            child: Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              children: [
                                                RepaintBoundary(
                                                  key: globalKey,
                                                  child: QrImageView(
                                                    data: widget
                                                        .requestEntity.id!,
                                                    version: QrVersions.auto,
                                                    size: 200.0,
                                                  ),
                                                ),
                                                Text(
                                                    "shipment id : ${widget.requestEntity.id!}"),
                                                ElevatedButton(
                                                    onPressed: () {
                                                      _captureAndSaveQrCode();
                                                    },
                                                    child: Padding(
                                                      padding:
                                                          const EdgeInsets.all(
                                                              10.0),
                                                      child: Text(
                                                        context.translate(
                                                            "export"),
                                                        style: const TextStyle(
                                                            color:
                                                                Colors.white),
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
                                    ScaffoldMessenger.of(context).showSnackBar(
                                        SnackBar(
                                            content: Text(context.translate(
                                                "Request Accepted Successfuly"))));
                                    Navigator.pushAndRemoveUntil(
                                        context,
                                        MaterialPageRoute(
                                            builder: (_) =>
                                                const BottomNavigationDelivery()),
                                        (route) => false);
                                  }
                                },
                                builder: (context, state) {
                                  if (state is AcceptRequsetLoadingState) {
                                    return const Center(
                                      child: CircularProgressIndicator(),
                                    );
                                  }
                                  return widget.requestEntity.status ==
                                          "Pending"
                                      ? CustomButtonWidget(
                                          height: 4,
                                          width: 18,
                                          title: context.translate("Accept"),
                                          fontSize: 2)
                                      : widget.requestEntity.status ==
                                                  "inProgress" &&
                                              widget.isDonor == false
                                          ? CustomButtonWidget(
                                              height: 4,
                                              width: 18,
                                              title: context.translate("Done"),
                                              fontSize: 2)
                                          : Container(
                                              color: Colors.white,
                                            );
                                },
                              )),
                          widget.requestEntity.status == "done"
                              ? Container(
                                  color: Colors.white,
                                )
                              : widget.requestEntity.status == "inProgress" &&
                                      widget.isDonor == true
                                  ? Container(
                                      color: Colors.white,
                                    )
                                  : GestureDetector(
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
                                      child: CustomButtonWidget(
                                          height: 4,
                                          width: 18,
                                          title: context.translate("CALL_NOW"),
                                          fontSize: 1.8),
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
        style: TextStyle(
            color: kPrimaryColor,
            fontSize: context.getDefaultSize() * 1.5,
            fontWeight: FontWeight.bold),
      ),
    );
  }

  Padding formTextField(BuildContext context, String hint,
      {TextEditingController? textEditingController, VoidCallback? onTap}) {
    return Padding(
      padding: EdgeInsets.only(
          right: context.getDefaultSize() * 2,
          left: context.getDefaultSize() * 2,
          bottom: context.getDefaultSize() * 1.5),
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
              hintStyle: TextStyle(
                  color: Colors.black,
                  fontSize: context.getDefaultSize() * 1.5),
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
                decoration: BoxDecoration(
                    image: DecorationImage(
                        image: NetworkImage(photo), fit: BoxFit.contain)),
              ),
              Container(
                height: context.getDefaultSize() * 15,
                width: context.getDefaultSize() * 15,
                color: Colors.grey.withOpacity(0.4),
                child: Center(
                  child: Text(
                    widget.requestEntity.items![index].quantity.toString(),
                    style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: context.getDefaultSize() * 3),
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
