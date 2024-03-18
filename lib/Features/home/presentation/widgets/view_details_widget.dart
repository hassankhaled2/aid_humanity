import 'package:aid_humanity/Features/home/presentation/bloc/home_bloc.dart';
import 'package:aid_humanity/core/widgets/BottomNavigation.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:aid_humanity/core/constants/constants.dart';
import 'package:aid_humanity/core/entities/request_entity.dart';
import 'package:aid_humanity/core/extensions/mediaquery_extension.dart';
import 'package:aid_humanity/core/widgets/custom_button_widget.dart';
import 'package:aid_humanity/core/widgets/defualt_app_bar_widget.dart';
import 'package:intl/intl.dart';

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
  Set<Marker> markers = {};

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0XFFE9EAEE),
      appBar: getDefaultAppBarWidget(context: context, title: "Donation Details", backgroundColor: kPrimaryColor, iconColor: Colors.white),
      body: Column(
        children: [
          Expanded(
            child: GoogleMap(
              markers: {Marker(markerId: const MarkerId("1"), position: LatLng(5, 5))},
              mapType: MapType.normal,
              onMapCreated: (GoogleMapController controller) {
                googleMapController = controller;
              },
              initialCameraPosition: CameraPosition(
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
                child: ListView(
                  children: [
                    Padding(
                      padding: EdgeInsets.only(
                        top: context.getDefaultSize() * 2,
                        left: context.getDefaultSize() * 2,
                      ),
                      child: Row(
                        children: [
                          Column(
                            children: [
                              Text(
                                "Menna Ahmed",
                                style: TextStyle(fontSize: context.getDefaultSize() * 2, color: Colors.black, fontWeight: FontWeight.bold),
                              ),
                              SizedBox(height: context.getDefaultSize() * 3)
                            ],
                          ),
                          SizedBox(
                            width: context.getDefaultSize() * 14,
                          ),
                          Column(
                            children: [
                              Container(
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
                              SizedBox(
                                height: context.getDefaultSize(),
                              ),
                              Row(children: [
                                Icon(
                                  FontAwesomeIcons.arrowUpRightFromSquare,
                                  size: 12,
                                  color: Colors.grey[600],
                                ),
                                SizedBox(
                                  width: context.getDefaultSize() * 1,
                                ),
                                Text(
                                  "8 km",
                                  style: TextStyle(fontSize: context.getDefaultSize() * 1.7, color: Colors.grey[600]),
                                ),
                              ]),
                            ],
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: context.getDefaultSize(),
                    ),
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
                    Container(height: 100, child: ListView.builder(scrollDirection: Axis.horizontal, itemCount: widget.requestEntity.numberOfItems, itemBuilder: (_, index) => formTextField(context, widget.requestEntity.items![index].type))),
                    SizedBox(
                      width: context.getDefaultSize() * 8,
                    ),
                    Container(
                      height: 150,
                      child: ListView.builder(
                          scrollDirection: Axis.horizontal,
                          itemCount: widget.requestEntity.items!.length,
                          itemBuilder: (_, index) => Column(
                                children: [photoWidget(context, widget.requestEntity.items![index].image), Text("category:"), Text(widget.requestEntity.items![index].category)],
                              )),
                    )
                  ],
                ),
              ),
              Center(
                child: Padding(
                  padding: EdgeInsets.all(context.getDefaultSize() * 2),
                  child: GestureDetector(
                      onTap: () {
                        BlocProvider.of<HomeBloc>(context).add(AcceptRequestEvent(requestId: widget.requestEntity.id!, deliveryId: FirebaseAuth.instance.currentUser!.uid, status: "inProgress"));
                      },
                      child: BlocConsumer<HomeBloc, HomeState>(
                        listener: (context, state) {
                          if (state is AcceptRequsetSuccessState) {
                            ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Request Accepted Successfuly")));
                            Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (_) => const BottomNavigation()), (route) => false);
                          }
                        },
                        builder: (context, state) {
                          if (state is AcceptRequsetLoadingState) {
                            return const Center(
                              child: CircularProgressIndicator(),
                            );
                          }
                          return widget.requestEntity.status == "Pending" ? CustomButtonWidget(height: 4, width: 18, title: "Accept", fontSize: 2) : Container();
                        },
                      )),
                ),
              )
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
      child: Container(
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

  Padding photoWidget(BuildContext context, String photo) {
    return Padding(
      padding: EdgeInsets.all(context.getDefaultSize()),
      child: Container(
        height: context.getDefaultSize() * 9,
        width: context.getDefaultSize() * 9,
        decoration: BoxDecoration(image: DecorationImage(image: NetworkImage(photo), fit: BoxFit.cover)),
      ),
    );
  }
}
