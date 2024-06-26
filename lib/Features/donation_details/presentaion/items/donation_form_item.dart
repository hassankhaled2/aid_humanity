// ignore_for_file: prefer_interpolation_to_compose_strings, sized_box_for_whitespace

import 'dart:io';
import 'package:aid_humanity/Features/donation_details/presentaion/bloc/ai_model_cubit/cubit/classificaiton_cubit.dart';
import 'package:aid_humanity/Features/donation_details/presentaion/bloc/details_bloc.dart';
import 'package:aid_humanity/core/entities/item_entity.dart';
import 'package:aid_humanity/core/entities/request_entity.dart';
import 'package:aid_humanity/core/extensions/mediaquery_extension.dart';
import 'package:aid_humanity/core/extensions/translation_extension.dart';
import 'package:aid_humanity/core/utils/constants.dart';
import 'package:aid_humanity/core/utils/theme/app_color/app_color_light.dart';
import 'package:aid_humanity/core/utils/theme/cubit/theme_cubit.dart';
import 'package:aid_humanity/core/widgets/BottomNavigationDonor.dart';
import 'package:aid_humanity/core/widgets/custom_button_widget.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dio/dio.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/intl.dart';

class DonationFormItem extends StatefulWidget {
  const DonationFormItem({
    super.key,
    required this.items,
    required this.isKnn,
    this.itemsImages,
  });

  final bool isKnn;
  final List<Map<String, dynamic>> items;
  final List<File>? itemsImages;
  @override
  State<DonationFormItem> createState() => _DonationFormItemState();
}

class _DonationFormItemState extends State<DonationFormItem> {
  late TextEditingController quantityController;
  final TextEditingController itemsController = TextEditingController();
  final TextEditingController locationController = TextEditingController();
  final TextEditingController governmentController = TextEditingController();
  final TextEditingController cityController = TextEditingController();
  final TextEditingController dateController = TextEditingController();
  late DateTime date = DateTime.now();
  List<ItemEntity> items = [];

  int totalQuantity = 0;
  List<int>? itemQ;
  Map<String, dynamic>? userDetails;

  void _onDecrement(int index) {
    setState(() {
      if (itemQ![index] > 0 && totalQuantity > 0) {
        itemQ![index]--;
        totalQuantity--;
        quantityController =
            TextEditingController(text: totalQuantity.toString());
      } else {
        itemQ = itemQ;
        totalQuantity = totalQuantity;
      }
    });
  }

  void _onIncrement(int index) {
    setState(() {
      itemQ![index]++;
      totalQuantity++;
      quantityController =
          TextEditingController(text: totalQuantity.toString());
    });
  }

  Future<Map<String, dynamic>?> getUserDetailsByRequestId(
      String requestId) async {
    final firestore = FirebaseFirestore.instance;
    // Get the request document reference
    final userId = FirebaseAuth.instance.currentUser!.uid;
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
    final city = userDoc.data()['city'];
    final region = userDoc.data()['region'];
    final street = userDoc.data()['street'];
    final flatNumber = userDoc.data()['flatNumber'];

    // Return user details as a map
    return {
      'city': city,
      'region': region,
      'street': street,
      'flatNumber': flatNumber,
    };
  }

  void onDecrement(int index) {
    setState(() {
      if (itemQ![index] > 0 && totalQuantity > 2) {
        itemQ![index]--;
        totalQuantity--;
        quantityController =
            TextEditingController(text: totalQuantity.toString());
      } else {
        itemQ = itemQ;
        totalQuantity = totalQuantity;
      }
    });
  }

  void onIncrement(int index) {
    setState(() {
      itemQ![index]++;
      totalQuantity++;
      quantityController =
          TextEditingController(text: totalQuantity.toString());
    });
  }

  @override
  void initState() {
    _fetchUserDetails();
    if (widget.itemsImages != null)
      itemQ =
          List.filled(widget.itemsImages!.length, widget.itemsImages!.length);
    else
      itemQ = List.filled(widget.items!.length, widget.items.length);

    super.initState();
    itemsController.text = widget.items.toString();
    dateController.text = DateFormat.yMMMd().format(date);
    quantityController =
        TextEditingController(text: widget.items.length.toString());
    totalQuantity = widget.items.length;
  }

  Future<void> _fetchUserDetails() async {
    final details =
        await getUserDetailsByRequestId(FirebaseAuth.instance.currentUser!.uid);
    print("-------------------------------------------------------------");
    print(details);
    setState(() {
      userDetails = details;
      governmentController.text = userDetails!["city"].toString();
      cityController.text = userDetails!["region"].toString();
      locationController.text = "Street  " +
          userDetails!["street"] +
          "  Flat Number  " +
          userDetails!["flatNumber"].toString();
    });
  }

  @override
  void dispose() {
    super.dispose();
    itemsController.dispose();
    locationController.dispose();
    dateController.dispose();
    quantityController.dispose();
    governmentController.dispose();
    cityController.dispose();
  }

  int quantity = 1;
  @override
  Widget build(BuildContext context) {
    return BlocListener<ClassificaitonCubit, ClassificaitonState>(
      listener: (context, state) {
        if (state is KnnClassificaitonsSuccessState) {
          final knnResults = state.knnOutput.toString();
          print(knnResults); // Access the results

          for (int i = 0; i < widget.items.length; i++) {
            ItemEntity itemEntity = ItemEntity(
              type: widget.items[i]["Type"]!,
              category: widget.items[i]["Master"]!,
              gender: widget.items[i]["Gender"]!,
              quantity: itemQ![i],
              image:
                  'https://t4.ftcdn.net/jpg/04/73/25/49/360_F_473254957_bxG9yf4ly7OBO5I0O5KABlN930GwaMQz.jpg',
            );
            items.add(itemEntity);
            print(items);
          }
        }
      },
      child: BlocListener<DetailsBloc, DetailsState>(
        listener: (context, state) {
          if (state is UploadImagesSuccessState) {
            for (int i = 0; i < widget.items.length; i++) {
              ItemEntity itemEntity = ItemEntity(
                type: widget.items[i]["Type"]!,
                category: widget.items[i]["Master"]!,
                gender: widget.items[i]["Gender"]!,
                image: state.imagesUrls[i],
                quantity: itemQ![i],
              );
              items.add(itemEntity);
            }

            BlocProvider.of<DetailsBloc>(context).add(AddRequestEvent(
                requestEntity: RequestEntity(
                    time: date,
                    address: {
                      "government": governmentController.text,
                      "city": cityController.text,
                      "location": locationController.text
                    },
                    numberOfItems: totalQuantity,
                    userId: FirebaseAuth.instance.currentUser!.uid,
                    status: "Pending",
                    qrScanned: false),
                items: items));
          } else if (state is UploadImagesErrorState) {
            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                content: Text(context
                    .translate("Please_check_your_internet_connection"))));
          }
        },
        child: Scaffold(
            body: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: EdgeInsets.only(
                top: context.getDefaultSize() * 3,
                right: context.getDefaultSize() * 2,
                left: context.getDefaultSize() * 2,
                bottom: context.getDefaultSize() * 2,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    context.translate("Donate_Request_Details"),
                    style: TextStyle(
                        color: kPrimaryColor,
                        fontSize: context.getDefaultSize() * 2.6,
                        fontWeight: FontWeight.bold,
                        fontFamily: "static"),
                  ),
                  IconButton(
                    icon: Icon(
                      FontAwesomeIcons.circleXmark,
                      color: const Color.fromARGB(255, 133, 132, 132),
                      size: context.getDefaultSize() * 3,
                    ),
                    onPressed: () {
                      Navigator.pop(context);
                    },
                  ),
                ],
              ),
            ),
            Expanded(
                child: Padding(
              padding: EdgeInsets.only(
                left:
                    BlocProvider.of<ThemeCubit>(context).locale.languageCode ==
                            "en"
                        ? context.getDefaultSize() / 1.5
                        : 0,
                right:
                    BlocProvider.of<ThemeCubit>(context).locale.languageCode ==
                            "ar"
                        ? context.getDefaultSize() * 2
                        : 0,
              ),
              child: ListView(children: [
                addressText(context, context.translate("Pickup_location")),
                SizedBox(
                  height: context.getDefaultSize() * 2,
                ),
                Row(children: [
                  addressText(context, context.translate("Government_")),
                  SizedBox(
                    width: context.getDefaultSize() * 13,
                  ),
                  addressText(context, context.translate("City_")),
                ]),
                Row(children: [
                  Container(
                    width: context.getDefaultSize() * 19,
                    height: context.getDefaultSize() * 9,
                    child: formTextField(context,
                        textEditingController: governmentController),
                  ),
                  SizedBox(
                    width: context.getDefaultSize() * 1.3,
                  ),
                  Container(
                    width: context.getDefaultSize() * 19,
                    height: context.getDefaultSize() * 9,
                    child: formTextField(context,
                        textEditingController: cityController),
                  )
                ]),
                addressText(
                    context, context.translate("Remaining_address_in_detail")),
                formTextField(context,
                    textEditingController: locationController),
                addressText(context, context.translate("Pickup_day")),
                formTextField(
                  context,
                  textEditingController: dateController,
                  onTap: () async {
                    date = await _pickDate();
                  },
                ),
                addressText(context, context.translate("Quantity_n_pieces")),
                formTextField(context,
                    textEditingController: quantityController, readOnly: true),
                addressText(context, context.translate("Items")),
                widget.isKnn
                    ? SizedBox(
                        height: context.getDefaultSize() * 25,
                        width: double.infinity,
                        child: ListView.builder(
                          itemBuilder: (context, index) => photoWidget(context,
                              File('assets/pics/defaultImage.jpg'), index),
                          itemCount: widget.items.length,
                          shrinkWrap: true,
                          scrollDirection: Axis.horizontal,
                          physics: const BouncingScrollPhysics(),
                        ),
                      )
                    : SizedBox(
                        height: context.getDefaultSize() * 25,
                        width: double.infinity,
                        child: ListView.builder(
                          itemBuilder: (context, index) => photoWidget(
                              context, widget.itemsImages![index], index),
                          itemCount: widget.itemsImages!.length,
                          shrinkWrap: true,
                          scrollDirection: Axis.horizontal,
                          physics: const BouncingScrollPhysics(),
                        ),
                      )
              ]),
            )),
            BlocConsumer<DetailsBloc, DetailsState>(
              listener: (context, state) {
                if (state is AddRequestSucccessState) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                        content: Text(context
                            .translate("Request_Submitted_successfully"))),
                  );
                  Navigator.pushAndRemoveUntil(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const BottomNavigationDonor()),
                      (route) => false);
                }
                if (state is AddRequestErrorState) {
                  if (state.message ==
                      context.translate("check_your_internet_connection")) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                          content: Text(context
                              .translate("check_your_internet_connection"))),
                    );
                  }
                }
              },
              builder: (context, state) {
                if (state is AddRequestLoadingState ||
                    state is UploadImagesLoadingState) {
                  return const Center(
                    child: CircularProgressIndicator(
                      color: AppColorsLight.primaryColor,
                    ),
                  );
                } else {
                  return Center(
                    child: Padding(
                      padding: EdgeInsets.all(context.getDefaultSize()),
                      child: GestureDetector(
                        onTap: () {
                          if (widget.isKnn) {
                            List<ItemEntity> items = [
                              ItemEntity(
                                  type: widget.items[0]['Type'],
                                  category: widget.items[0]['Master'],
                                  gender: widget.items[0]['Gender'],
                                  image:
                                      "https://t4.ftcdn.net/jpg/04/73/25/49/360_F_473254957_bxG9yf4ly7OBO5I0O5KABlN930GwaMQz.jpg",
                                  quantity: 1),
                            ];
                            BlocProvider.of<DetailsBloc>(context)
                                .add(AddRequestEvent(
                              requestEntity: RequestEntity(
                                time: date,
                                address: {
                                  "government": governmentController.text,
                                  "city": cityController.text,
                                  "location": locationController.text
                                },
                                numberOfItems: totalQuantity,
                                userId: FirebaseAuth.instance.currentUser!.uid,
                                status: "Pending",
                                qrScanned: false,
                              ),
                              items: items,
                            ));
                          } else {
                            BlocProvider.of<DetailsBloc>(context).add(
                                UploadImagesEvent(images: widget.itemsImages!));
                          }
                        },
                        child: // BlocConsumer<HomeBloc, HomeState>(
                            //         listener: (context, state) {
                            //           if (state is AcceptRequsetSuccessState) {
                            //             ScaffoldMessenger.of(context).showSnackBar(
                            //                 const SnackBar(
                            //                     content: Text(
                            //                         "Request ِAdded Successfuly")));
                            //             Navigator.pushAndRemoveUntil(
                            //                 context,
                            //                 MaterialPageRoute(
                            //                     builder: (_) =>
                            //                         const BottomNavigationDonor()),
                            //                 (route) => false);
                            //           }
                            //         },
                            //         builder: (context, state) {
                            //           if (state is AcceptRequsetLoadingState) {
                            //             return const Center(
                            //               child: CircularProgressIndicator(),
                            //             );
                            //           }
                            //         return
                            CustomButtonWidget(
                                height: 4,
                                width: 18,
                                title: context.translate("Accept"),
                                fontSize: 2),
                        //   },
                        //  )
                      ),
                    ),
                  );
                }
              },
            )
          ],
        )),
      ),
    );
  }

  Padding photoWidget(BuildContext context, File photo, int index) {
    return Padding(
      padding: EdgeInsets.symmetric(
          vertical: context.getDefaultSize() * 5,
          horizontal: context.getDefaultSize()),
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          Container(
            height: context.getDefaultSize() * 15,
            width: context.getDefaultSize() * 18,
            decoration: BoxDecoration(
                image: DecorationImage(
                    image: FileImage(photo), fit: BoxFit.cover)),
          ),
          Positioned(
            right: 0,
            top: 0,
            child: Container(
              color: Colors.grey.withOpacity(0.5),
              height: context.getDefaultSize() * 15,
              width: context.getDefaultSize() * 18,
              child: Row(children: [
                IconButton(
                  onPressed: () {
                    _onDecrement(index);
                  },
                  icon: Icon(
                    Icons.navigate_before_sharp,
                    color: Colors.black,
                    size: context.getDefaultSize() * 4,
                    weight: 100,
                    shadows: const [
                      Shadow(
                          color: Colors.white,
                          blurRadius: 10,
                          offset: Offset(-2, -1))
                    ],
                  ),
                ),
                SizedBox(
                  width: context.getDefaultSize() * 1.5,
                ),
                Text(
                  itemQ![index].toString(),
                  style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                      fontSize: context.getDefaultSize() * 2.5),
                ),
                SizedBox(
                  width: context.getDefaultSize() * 1.5,
                ),
                IconButton(
                  onPressed: () {
                    _onIncrement(index);
                  },
                  icon: Icon(
                    Icons.navigate_next_sharp,
                    color: kPrimaryColor,
                    size: context.getDefaultSize() * 4,
                    weight: 100,
                    shadows: const [
                      Shadow(
                          color: Colors.white,
                          blurRadius: 10,
                          offset: Offset(2, 1))
                    ],
                  ),
                ),
              ]),
            ),
          ),
          Positioned(
              right: 50,
              top: -25,
              child: Text(
                widget.items[index]["Type"]!,
                style: TextStyle(
                    color: Colors.black,
                    fontSize: context.getDefaultSize() * 2),
              ))
        ],
      ),
    );
  }

  Padding formTextField(BuildContext context,
      {TextEditingController? textEditingController,
      VoidCallback? onTap,
      bool readOnly = false}) {
    return Padding(
      padding: EdgeInsets.only(
          right: context.getDefaultSize() * 2,
          left: context.getDefaultSize() * 2,
          bottom: context.getDefaultSize() * 2),
      child: TextField(
        onTap: onTap,
        readOnly: readOnly,
        controller: textEditingController,
        style: TextStyle(
          color: Colors.black,
          fontSize: context.getDefaultSize() * 2,
        ),
        autocorrect: true,
        cursorColor: kPrimaryColor,
        scribbleEnabled: true,
        decoration: InputDecoration(
            focusedBorder: UnderlineInputBorder(
              borderSide: BorderSide(color: kPrimaryColor),
            ),
            enabledBorder: UnderlineInputBorder(
              borderSide: BorderSide(color: Colors.grey.withOpacity(0.4)),
            )),
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
            color: Colors.grey.withOpacity(0.7),
            fontSize: context.getDefaultSize() * 1.5,
            fontWeight: FontWeight.bold),
      ),
    );
  }

  Future<DateTime> _pickDate() async {
    DateTime? date = await showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime(2022),
        lastDate: DateTime(2050));
    if (date != null) {
      setState(() {
        dateController.text = DateFormat.yMMMd().format(date);
      });
      return date;
    }
    return date!;
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties.add(IntProperty('totalQuantity', totalQuantity));
  }
}
