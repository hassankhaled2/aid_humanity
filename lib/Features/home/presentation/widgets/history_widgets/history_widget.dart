import 'package:aid_humanity/core/extensions/translation_extension.dart';
import 'package:aid_humanity/core/utils/theme/cubit/theme_cubit.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:aid_humanity/core/entities/request_entity.dart';
import 'package:aid_humanity/core/extensions/mediaquery_extension.dart';
import 'package:aid_humanity/core/utils/constants.dart';

class HistoryWidget extends StatefulWidget {
  final RequestEntity request;
  HistoryWidget({Key? key, required this.request}) : super(key: key);

  @override
  State<HistoryWidget> createState() => _HistoryWidgetState();
}

class _HistoryWidgetState extends State<HistoryWidget> {
  String? userName = "";
  bool isLoading = true;
  String? phoneNumber = "";
  Map<String, dynamic>? userDetails = {};

  Future<Map<String, dynamic>?> getUserDataByRequestId(String requestId) async {
    final firestore = FirebaseFirestore.instance;
    // Get the request document reference
    final userId = widget.request.userId;
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
    final phoneNumber = userDoc.data()['Phone'];
    return {
      'name': userName,
      'phoneNumber': phoneNumber,
    };
  }

  void initState() {
    _fetchUserName();
    super.initState();
  }

  Future<void> _fetchUserName() async {
    final details = await getUserDataByRequestId(widget.request.userId);
    setState(() {
      userDetails = details;
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
          right: context.getDefaultSize() * 2,
          left: context.getDefaultSize() * 2,
          top: context.getDefaultSize() * 1.5),
      child: Container(
        width: context.getDefaultSize(),
        decoration: BoxDecoration(
            border: Border.all(
              color: Colors.grey.withOpacity(0.5),
            ),
            borderRadius: BorderRadius.circular(context.getDefaultSize())),
        child: Row(mainAxisAlignment: MainAxisAlignment.center, children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                rowDataWidget(
                    Icon(
                      Icons.card_membership,
                      color: kPrimaryColor,
                      size: context.getDefaultSize() * 1.5,
                    ),
                    context.translate("Request_Id"),
                    "${widget.request.id}",
                    context),
                rowDataWidget(
                    Icon(
                      Icons.person,
                      color: kPrimaryColor,
                      size: context.getDefaultSize() * 1.5,
                    ),
                    context.translate("Donor_Name"),
                    userDetails?["name"] ?? "Data not found",
                    context),
                rowDataWidget(
                    Icon(
                      Icons.phone,
                      color: kPrimaryColor,
                      size: context.getDefaultSize() * 1.5,
                    ),
                    context.translate("Contact_number"),
                    userDetails?["phoneNumber"] ?? "Data not found",
                    context),
                rowDataWidget(
                    Icon(
                      Icons.location_city,
                      color: kPrimaryColor,
                      size: context.getDefaultSize() * 1.5,
                    ),
                    context.translate("Address"),
                    widget.request.address["location"].toString(),
                    context),
                rowDataWidget(
                    Icon(
                      Icons.card_membership,
                      color: kPrimaryColor,
                      size: context.getDefaultSize() * 1.5,
                    ),
                    context.translate("Items_quantity"),
                    "${widget.request.numberOfItems}",
                    context),
              ],
            ),
          ),
          Padding(
            padding: EdgeInsets.only(
              top: context.getDefaultSize(),
              left: BlocProvider.of<ThemeCubit>(context).locale.languageCode ==
                      "en"
                  ? context.getDefaultSize() * 2
                  : 0,
              right: BlocProvider.of<ThemeCubit>(context).locale.languageCode ==
                      "ar"
                  ? context.getDefaultSize() * 2
                  : 0,
            ),
            child: Padding(
              padding: EdgeInsets.only(right: context.getDefaultSize()),
              child: Column(
                children: [
                  Text(
                    DateFormat('yyyy-MM-dd').format(widget.request.time),
                    style: TextStyle(
                        fontSize: context.getDefaultSize(),
                        fontWeight: FontWeight.bold),
                  ),
                  Text(
                    DateFormat.jm().format(widget.request.time),
                    style: TextStyle(
                        fontSize: context.getDefaultSize(),
                        fontWeight: FontWeight.bold),
                  ),
                  SizedBox(
                    height: context.getDefaultSize() * 11,
                  ),
                ],
              ),
            ),
          )
        ]),
      ),
    );
  }

  Padding rowDataWidget(
      Icon icon, String title, String data, BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(
          horizontal: context.getDefaultSize() / 2,
          vertical: context.getDefaultSize() / 2),
      child: Row(
        children: [
          icon,
          SizedBox(
            width: context.getDefaultSize() / 2,
          ),
          Text(
            "$title :",
            style: TextStyle(
                color: Colors.black, fontSize: context.getDefaultSize() * 1.2),
          ),
          Container(
            width: context.getDefaultSize() * 15,
            height: context.getDefaultSize() * 2,
            child: ListView(
              scrollDirection: Axis.horizontal,
              children: [
                Text(data,
                    style: TextStyle(
                        color: Colors.black.withOpacity(0.6),
                        fontSize: context.getDefaultSize() * 1.2)),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
