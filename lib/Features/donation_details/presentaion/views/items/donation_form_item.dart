import 'dart:ui';

import 'package:aid_humanity/core/extensions/mediaquery_extension.dart';
import 'package:aid_humanity/core/utils/constants.dart';
import 'package:aid_humanity/core/widgets/custom_button_widget.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class DonationFormItem extends StatelessWidget {
  const DonationFormItem({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
            children: [
              Padding(
                padding: EdgeInsets.only(right: context.getDefaultSize() * 8),
                child: Text(
                  "Donate Item Details",
                  style: TextStyle(
                      color: kPrimaryColor,
                      fontSize: context.getDefaultSize() * 2.6,
                      fontWeight: FontWeight.bold,
                      fontFamily: "static"),
                ),
              ),
              IconButton(
                icon: Icon(
                  FontAwesomeIcons.circleXmark,
                  color:const Color.fromARGB(255, 133, 132, 132),
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
            child: ListView(children: [
          addressText(context, "Pickup location"),
          formTextField(context),
          addressText(context, "Item(s)"),
          formTextField(context),
          addressText(context, "Preferred Time"),
          formTextField(context),
          addressText(context, "Pickup Day"),
          formTextField(context),
          addressText(context, "Quantity : n pieces"),
          formTextField(context),
          addressText(context, "Photos"),
          Row(
            children: [
              photoWidget(context,
                  "https://th.bing.com/th/id/R.727222a31052a78ea48a8f082d8fe5f1?rik=tQlJtaGKqyR8CA&riu=http%3a%2f%2fwww.thehomestyledirectory.com%2fa%2fwp-content%2fuploads%2f2012%2f02%2f6.jpg&ehk=KiPJ%2fPSDUR%2fDzsiz74J2IqJMxL%2fI1jNzwhsjOndyDJg%3d&risl=&pid=ImgRaw&r=0"),
              photoWidget(context,
                  "https://th.bing.com/th/id/R.71fa39dec7d38c8aab2082b7df5baa14?rik=KHUuG6sgSpqnlw&pid=ImgRaw&r=0"),
              photoWidget(context,
                  "https://th.bing.com/th/id/R.fa055ca52eacaf8dede7b27d817b2858?rik=u4IwtUqoM59nAQ&pid=ImgRaw&r=0"),
            ],
          )
        ])),
        Center(
          child: Padding(
            padding: EdgeInsets.all(context.getDefaultSize()),
            child: CustomButtonWidget(
                height: 4, width: 20, title: "Submit", fontSize: 2),
          ),
        )
      ],
    ));
  }

  Padding photoWidget(BuildContext context, String photo) {
    return Padding(
      padding: EdgeInsets.all(context.getDefaultSize()),
      child: Container(
        height: 70,
        width: 70,
        decoration: BoxDecoration(
            image:
                DecorationImage(image: NetworkImage(photo), fit: BoxFit.cover)),
      ),
    );
  }

  Padding formTextField(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
          right: context.getDefaultSize() * 2,
          left: context.getDefaultSize() * 2,
          bottom: context.getDefaultSize() * 2),
      child: TextField(
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
}
