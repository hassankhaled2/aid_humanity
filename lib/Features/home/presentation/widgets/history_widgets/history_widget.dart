import 'package:aid_humanity/core/extensions/mediaquery_extension.dart';
import 'package:aid_humanity/core/utils/constants.dart';
import 'package:flutter/material.dart';

class HistoryWidget extends StatelessWidget {
  const HistoryWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(
          horizontal: context.getDefaultSize() * 3,
          vertical: context.getDefaultSize() / 1.5),
      child: Container(
        width: context.getDefaultSize(),
        decoration: BoxDecoration(
            border: Border.all(
              color: Colors.grey.withOpacity(0.5),
            ),
            borderRadius: BorderRadius.circular(context.getDefaultSize())),
        child: Row(mainAxisAlignment: MainAxisAlignment.center, children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
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
                    Icons.location_on,
                    color: kPrimaryColor,
                    size: context.getDefaultSize() * 1.5,
                  ),
                  "Location",
                  "El-shrouk city",
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
            ],
          ),
          Padding(
            padding: EdgeInsets.only(
                top: context.getDefaultSize(), left: context.getDefaultSize()),
            child: Column(
              children: [
                Text(
                  "Date:24/2/23 ",
                  style: TextStyle(fontSize: context.getDefaultSize()),
                ),
                Text(
                  "Time: 11:11pm",
                  style: TextStyle(fontSize: context.getDefaultSize()),
                ),
                SizedBox(
                  height: context.getDefaultSize() * 2,
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

  Padding rowDataWidget(
      Icon icon, String title, String data, BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(4),
      child: Row(
        children: [
          icon,
          Text(
            "$title :",
            style: TextStyle(
                color: Colors.black, fontSize: context.getDefaultSize() * 1.2),
          ),
          Text(data,
              style: TextStyle(
                  color: Colors.black.withOpacity(0.6),
                  fontSize: context.getDefaultSize() * 1.2))
        ],
      ),
    );
  }
}
