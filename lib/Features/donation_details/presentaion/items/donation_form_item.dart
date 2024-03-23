import 'dart:io';
import 'dart:math';
import 'package:aid_humanity/Features/donation_details/presentaion/bloc/ai_model_cubit/cubit/classificaiton_cubit.dart';
import 'package:aid_humanity/Features/donation_details/presentaion/bloc/details_bloc.dart';
import 'package:aid_humanity/Features/home/presentation/pages/home_donor_page.dart';
import 'package:aid_humanity/core/entities/item_entity.dart';
import 'package:aid_humanity/core/entities/request_entity.dart';
import 'package:aid_humanity/core/extensions/mediaquery_extension.dart';
import 'package:aid_humanity/core/utils/constants.dart';
import 'package:aid_humanity/core/utils/theme/app_color/app_color_light.dart';
import 'package:aid_humanity/core/widgets/BottomNavigation.dart';
import 'package:aid_humanity/core/widgets/custom_button_widget.dart';
import 'package:firebase_auth/firebase_auth.dart';
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
  final TextEditingController dateController = TextEditingController();
  late DateTime date = DateTime.now();
  List<ItemEntity> items = [];

  int totalQuantity = 0;
  List<int>? itemQ;

  void _onDecrement(int index) {
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

  void _onIncrement(int index) {
    setState(() {
      itemQ![index]++;
      totalQuantity++;
      quantityController =
          TextEditingController(text: totalQuantity.toString());
    });
  }

  @override
  void initState() {
    if (widget.itemsImages != null)
      itemQ = List.filled(widget.itemsImages!.length, 1);
    else
      itemQ = List.filled(widget.items.length, 1);
    super.initState();
    itemsController.text = widget.items.toString();
    dateController.text = DateFormat.yMMMd().format(date);
    quantityController =
        TextEditingController(text: widget.items.length.toString());
    totalQuantity = widget.items.length;
  }

  @override
  void dispose() {
    super.dispose();
    itemsController.dispose();
    locationController.dispose();
    dateController.dispose();
    quantityController.dispose();
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
                    address: {"location": locationController.text},
                    numberOfItems: widget.items.length,
                    userId: FirebaseAuth.instance.currentUser!.uid,
                    status: "Pending"),
                items: items));
          } else if (state is UploadImagesErrorState) {
            ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                content: Text("Please check your internet connection")));
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
                    "Donate Request Details",
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
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => (const HomeDonorPage())),
                      );
                    },
                  ),
                ],
              ),
            ),
            Expanded(
                child: ListView(children: [
              addressText(context, "Pickup location"),
              formTextField(context, textEditingController: locationController),
              addressText(context, "Pickup Day"),
              formTextField(
                context,
                textEditingController: dateController,
                onTap: () async {
                  date = await _pickDate();
                },
              ),
              addressText(context, "Quantity : n pieces"),
              formTextField(context,
                  textEditingController: quantityController, readOnly: true),
              addressText(context, "Items"),
              widget.isKnn
                  ? SizedBox(
                      height: context.getDefaultSize() * 25,
                      width: double.infinity,
                      child: ListView.builder(
                        itemBuilder: (context, index) => photoWidget(
                            context,
                            null,
                            index,
                            "https://t4.ftcdn.net/jpg/04/73/25/49/360_F_473254957_bxG9yf4ly7OBO5I0O5KABlN930GwaMQz.jpg"),
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
                            context, widget.itemsImages![index], index, ""),
                        itemCount: widget.itemsImages!.length,
                        shrinkWrap: true,
                        scrollDirection: Axis.horizontal,
                        physics: const BouncingScrollPhysics(),
                      ),
                    )
            ])),
            BlocConsumer<DetailsBloc, DetailsState>(
              listener: (context, state) {
                if (state is AddRequestSucccessState) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                        content: Text("Request Submitted successfully")),
                  );
                  Navigator.pushAndRemoveUntil(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const BottomNavigation()),
                      (route) => false);
                }
                if (state is AddRequestErrorState) {
                  if (state.message == "check your internet con``nection") {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                          content: Text("check your internet connection")),
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
                            }
                            BlocProvider.of<DetailsBloc>(context).add(
                                AddRequestEvent(
                                    requestEntity: RequestEntity(
                                        time: date,
                                        address: {
                                          "location": locationController.text
                                        },
                                        numberOfItems: widget.items.length,
                                        userId: FirebaseAuth
                                            .instance.currentUser!.uid,
                                        status: "Pending"),
                                    items: items));
                          } else {
                            BlocProvider.of<DetailsBloc>(context).add(
                                UploadImagesEvent(images: widget.itemsImages!));
                          }
                        },
                        child: CustomButtonWidget(
                            height: 4, width: 20, title: "Submit", fontSize: 2),
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

  Padding photoWidget(
      BuildContext context, File? photo, int index, String? url) {
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
                    image: photo != null
                        ? FileImage(photo)
                        : NetworkImage(url!) as ImageProvider,
                    fit: BoxFit.cover)),
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
}
