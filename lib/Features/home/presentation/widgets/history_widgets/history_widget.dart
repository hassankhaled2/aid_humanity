import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:intl/intl.dart';
import 'package:aid_humanity/core/entities/request_entity.dart';
import 'package:aid_humanity/core/extensions/mediaquery_extension.dart';
import 'package:aid_humanity/core/utils/constants.dart';

class HistoryWidget extends StatelessWidget {
  final RequestEntity request;
  const HistoryWidget({
    Key? key,
    required this.request,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(right: context.getDefaultSize() * 3, left: context.getDefaultSize() * 3, top: context.getDefaultSize() * 1.5),
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
                    "Request Id",
                    "${request.id}",
                    context),
                rowDataWidget(
                    Icon(
                      Icons.person,
                      color: kPrimaryColor,
                      size: context.getDefaultSize() * 1.5,
                    ),
                    "Donor name",
                    "Menna Ahmed",
                    context),
                rowDataWidget(
                    Icon(
                      Icons.phone,
                      color: kPrimaryColor,
                      size: context.getDefaultSize() * 1.5,
                    ),
                    "Contact number",
                    "+011465697336",
                    context),
                rowDataWidget(
                    Icon(
                      Icons.location_city,
                      color: kPrimaryColor,
                      size: context.getDefaultSize() * 1.5,
                    ),
                    "Address",
                    "compound dar masr,...........",
                    context),
                rowDataWidget(
                    Icon(
                      Icons.card_membership,
                      color: kPrimaryColor,
                      size: context.getDefaultSize() * 1.5,
                    ),
                    "Items' quantity",
                    "${request.numberOfItems}",
                    context),
              ],
            ),
          ),
          Padding(
            padding: EdgeInsets.only(top: context.getDefaultSize(), right: context.getDefaultSize()),
            child: Column(
              children: [
                Text(
                  DateFormat('yyyy-MM-dd').format(request.time),
                  style: TextStyle(fontSize: context.getDefaultSize(), fontWeight: FontWeight.bold),
                ),
                Text(
                  DateFormat.jm().format(request.time),
                  style: TextStyle(fontSize: context.getDefaultSize(), fontWeight: FontWeight.bold),
                ),
                SizedBox(
                  height: context.getDefaultSize() * 7,
                ),
                IconButton(
                  onPressed: () {},
                  icon: Icon(
                    Icons.delete,
                    color: kPrimaryColor,
                    size: context.getDefaultSize() * 2,
                  ),
                  alignment: Alignment.bottomRight,
                ),
              ],
            ),
          )
        ]),
      ),
    );
  }

  Padding rowDataWidget(Icon icon, String title, String data, BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: context.getDefaultSize() / 2, vertical: context.getDefaultSize() / 2),
      child: Row(
        children: [
          icon,
          SizedBox(
            width: context.getDefaultSize() / 2,
          ),
          Text(
            "$title :",
            style: TextStyle(color: Colors.black, fontSize: context.getDefaultSize() * 1.2),
          ),
          Text(data, style: TextStyle(color: Colors.black.withOpacity(0.6), fontSize: context.getDefaultSize() * 1.2))
        ],
      ),
    );
  }
}
