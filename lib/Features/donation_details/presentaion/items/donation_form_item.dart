import 'dart:io';
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
  final TextEditingController itemsController = TextEditingController();
  final TextEditingController locationController = TextEditingController();
  final TextEditingController quantityController = TextEditingController();
  final TextEditingController dateController = TextEditingController();
  late DateTime date = DateTime.now();
  final List<ItemEntity> items = [];

  @override
  void initState() {
    super.initState();
    itemsController.text = widget.items.toString();
    quantityController.text = widget.items.length.toString();
    dateController.text = DateFormat.yMMMd().format(date);
  }

  @override
  void dispose() {
    super.dispose();
    itemsController.dispose();
    locationController.dispose();
    quantityController.dispose();
    dateController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<ClassificaitonCubit, ClassificaitonState>(
      listener: (context, state) {
        if (state is KnnClassificaitonsSuccessState) {}
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
              );
              items.add(itemEntity);
            }

            BlocProvider.of<DetailsBloc>(context).add(AddRequestEvent(requestEntity: RequestEntity(time: date, address: {"location": locationController.text}, numberOfItems: widget.items.length, userId: FirebaseAuth.instance.currentUser!.uid, status: "Pending"), items: items));
          } else if (state is UploadImagesErrorState) {
            ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("Please check your internet connection")));
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
                    style: TextStyle(color: kPrimaryColor, fontSize: context.getDefaultSize() * 2.6, fontWeight: FontWeight.bold, fontFamily: "static"),
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
                        MaterialPageRoute(builder: (context) => (const HomeDonorPage())),
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
              addressText(context, "Item(s)"),
              formTextField(context, textEditingController: itemsController),
              addressText(context, "Pickup Day"),
              formTextField(
                context,
                textEditingController: dateController,
                onTap: () async {
                  date = await _pickDate();
                },
              ),
              addressText(context, "Quantity : n pieces"),
              formTextField(context, textEditingController: quantityController),
              addressText(context, "Photos"),
              widget.isKnn
                  ? Center(
                      child: Image(image: NetworkImage("https://t4.ftcdn.net/jpg/04/73/25/49/360_F_473254957_bxG9yf4ly7OBO5I0O5KABlN930GwaMQz.jpg")),
                    )
                  : SizedBox(
                      height: context.getDefaultSize() * 15,
                      width: double.infinity,
                      child: ListView.builder(
                        itemBuilder: (context, index) => photoWidget(context, widget.itemsImages![index]),
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
                    const SnackBar(content: Text("Request Submitted successfully")),
                  );
                  Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context) => const BottomNavigation()), (route) => false);
                }
                if (state is AddRequestErrorState) {
                  if (state.message == "check your internet con``nection") {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text("check your internet connection")),
                    );
                  }
                }
              },
              builder: (context, state) {
                if (state is AddRequestLoadingState || state is UploadImagesLoadingState) {
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
                            List<ItemEntity> items = [ItemEntity(type: widget.items[0]['Type'], category: widget.items[0]['Master'], gender: widget.items[0]['Gender'], image: "https://t4.ftcdn.net/jpg/04/73/25/49/360_F_473254957_bxG9yf4ly7OBO5I0O5KABlN930GwaMQz.jpg")];
                            BlocProvider.of<DetailsBloc>(context).add(AddRequestEvent(requestEntity: RequestEntity(time: date, address: {"location": locationController.text}, numberOfItems: widget.items.length, userId: FirebaseAuth.instance.currentUser!.uid, status: "Pending"), items: items));
                          } else {
                            BlocProvider.of<DetailsBloc>(context).add(UploadImagesEvent(images: widget.itemsImages!));
                          }
                        },
                        child: CustomButtonWidget(height: 4, width: 20, title: "Submit", fontSize: 2),
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

  Padding photoWidget(BuildContext context, File photo) {
    return Padding(
      padding: EdgeInsets.all(context.getDefaultSize()),
      child: Container(
        height: context.getDefaultSize() * 15,
        width: context.getDefaultSize() * 10,
        decoration: BoxDecoration(image: DecorationImage(image: FileImage(photo), fit: BoxFit.cover)),
      ),
    );
  }

  Padding formTextField(BuildContext context, {TextEditingController? textEditingController, VoidCallback? onTap}) {
    return Padding(
      padding: EdgeInsets.only(right: context.getDefaultSize() * 2, left: context.getDefaultSize() * 2, bottom: context.getDefaultSize() * 2),
      child: TextField(
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
        style: TextStyle(color: Colors.grey.withOpacity(0.7), fontSize: context.getDefaultSize() * 1.5, fontWeight: FontWeight.bold),
      ),
    );
  }

  Future<DateTime> _pickDate() async {
    DateTime? date = await showDatePicker(context: context, initialDate: DateTime.now(), firstDate: DateTime(2022), lastDate: DateTime(2050));
    if (date != null) {
      setState(() {
        dateController.text = DateFormat.yMMMd().format(date);
      });
      return date;
    }
    return date!;
  }
}
