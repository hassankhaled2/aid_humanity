import 'package:aid_humanity/core/extensions/mediaquery_extension.dart';
import 'package:aid_humanity/core/utils/constants.dart';
import 'package:flutter/material.dart';

class HistoryWidget extends StatelessWidget {
  const HistoryWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(
          horizontal: context.getDefaultSize(),
          vertical: context.getDefaultSize() / 2),
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
                  ),
                  "Donor name",
                  "Menna Ahmed"),
              rowDataWidget(
                  Icon(
                    Icons.location_on,
                    color: kPrimaryColor,
                  ),
                  "Location",
                  "El-shrouk city"),
              rowDataWidget(
                  Icon(
                    Icons.phone,
                    color: kPrimaryColor,
                  ),
                  "Contact number",
                  "+011465697336"),
              rowDataWidget(
                  Icon(
                    Icons.location_city,
                    color: kPrimaryColor,
                  ),
                  "Address",
                  "compound dar masr,..........."),
            ],
          ),
          Column(
            children: [
              const Text("Date:24/2/23 "),
              const Text("Time: 11:11pm"),
              SizedBox(
                height: context.getDefaultSize() * 2,
              ),
              IconButton(
                onPressed: () {},
                icon: Icon(
                  Icons.delete,
                  color: kPrimaryColor,
                ),
                alignment: Alignment.bottomRight,
              ),
            ],
          )
        ]),
      ),
    );
  }

  Padding rowDataWidget(Icon icon, String title, String data) {
    return Padding(
      padding: const EdgeInsets.all(4),
      child: Row(
        children: [
          icon,
          Text(
            "$title :",
            style: const TextStyle(color: Colors.black),
          ),
          Text(data,
              style: TextStyle(
                color: Colors.black.withOpacity(0.6),
              ))
        ],
      ),
    );
  }
}
