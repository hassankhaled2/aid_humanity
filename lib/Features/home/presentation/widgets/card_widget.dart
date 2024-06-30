import 'package:aid_humanity/Features/home/presentation/widgets/view_details_widget.dart';
import 'package:aid_humanity/core/entities/request_entity.dart';
import 'package:aid_humanity/core/extensions/mediaquery_extension.dart';
import 'package:aid_humanity/core/extensions/translation_extension.dart';
import 'package:aid_humanity/core/widgets/default_elevated_button.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class CardWidget extends StatefulWidget {
  final RequestEntity requestEntity;
  bool isDonor;
  CardWidget({super.key, required this.requestEntity, required this.isDonor});

  @override
  State<CardWidget> createState() => _CardWidgetState();
}

class _CardWidgetState extends State<CardWidget> {
  String? userName = "";
  bool isLoading = true;

  Future<String?> getUserNameByRequestId(String requestId) async {
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
    final userName = userDoc.data()["fullName"];
    return userName;
  }

  void initState() {
    _fetchUserName();
    super.initState();
  }

  Future<void> _fetchUserName() async {
    final name = await getUserNameByRequestId(widget.requestEntity.userId);
    setState(() {
      userName = name;
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: EdgeInsets.only(
              left: context.getDefaultSize() * 3.4,
              right: context.getDefaultSize() * 3.4,
              bottom: context.getDefaultSize() * 1.4),
          child: Card(
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
            elevation: 3,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  decoration:
                      BoxDecoration(borderRadius: BorderRadius.circular(18)),
                  clipBehavior: Clip.antiAliasWithSaveLayer,
                  width: context.getDefaultSize() * 40,
                  child: Image(
                    height: context.getDefaultSize() * 13,
                    fit: BoxFit.cover,
                    image: NetworkImage(widget.requestEntity.items![0].image),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(
                      left: context.getDefaultSize() * .9,
                      top: context.getDefaultSize() * .8),
                  child: Container(
                    height: context.getDefaultSize() * 3,
                    width: context.getDefaultSize() * 20,
                    child: ListView(
                      scrollDirection: Axis.horizontal,
                      children: [
                        isLoading
                            ? const CircularProgressIndicator()
                            : Text(
                                userName ?? "Name not found",
                                style: TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold,
                                  fontSize: context.getDefaultSize() * 2.1,
                                ),
                                overflow: TextOverflow.ellipsis,
                              ),
                      ],
                    ),
                  ),
                ),
                Padding(
                    padding: EdgeInsets.only(
                        left: context.getDefaultSize() * .9,
                        bottom: context.getDefaultSize() * .6),
                    child: Column(
                      children: [
                        Container(
                            height: context.getDefaultSize() * 2.5,
                            width: context.getDefaultSize() * 20,
                            child: ListView(children: [
                              Text(
                                widget.requestEntity.address["government"],
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: context.getDefaultSize() * 2,
                                    color: Colors.black.withOpacity(0.6)),
                              )
                            ])),
                        SizedBox(
                          height: context.getDefaultSize() / 2,
                        ),
                        Container(
                            height: context.getDefaultSize() * 2.5,
                            width: context.getDefaultSize() * 20,
                            child: ListView(children: [
                              Text(
                                "-> " + widget.requestEntity.address["city"],
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black.withOpacity(0.6)),
                              )
                            ]))
                      ],
                    )),
                Padding(
                  padding: EdgeInsets.only(
                      left: context.getDefaultSize() * 2,
                      bottom: context.getDefaultSize() * 1),
                  child: Row(
                    children: [
                      SizedBox(
                        width: context.getDefaultSize() * 18.5,
                      ),
                      DefaultElevatedButton(
                        onPressed: () {
                          Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) => ViewDetailsWidget(
                                    requestEntity: widget.requestEntity,
                                    isDonor: widget.isDonor,
                                  )));
                        },
                        text: context.translate("Details"),
                        radius: 10,
                        height: context.getDefaultSize() * 2.85,
                        width: context.getDefaultSize() * 12,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
