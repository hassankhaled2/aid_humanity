import 'package:aid_humanity/core/utils/constants.dart';
import 'package:flutter/material.dart';

AppBar chatingAppBar(context) {
  return AppBar(
    leading: chatingLeadingAppBar(context),
    centerTitle: false,
    backgroundColor: Colors.white,
    elevation: 0.5,
    actions: [
      IconButton(
        onPressed: () {},
        icon: const Icon(
          Icons.phone,
          color: Colors.black,
          size: 30,
        ),
      )
    ],
    title: chatingAppbarTitle(),
  );
}

IconButton chatingLeadingAppBar(context) {
  return IconButton(
    icon: const Icon(Icons.arrow_back, color: Colors.black),
    onPressed: () {
      Navigator.of(context).pop();
    },
  );
}

Row chatingAppbarTitle() {
  return Row(
    mainAxisAlignment: MainAxisAlignment.start,
    children: [
      const Padding(
        padding: EdgeInsets.only(right: 16),
        child: CircleAvatar(
          backgroundImage: NetworkImage(
            "https://i.pinimg.com/736x/bf/b4/54/bfb454b2b6df93d772c88e866207db29--stunning-girls-beautiful-person.jpg",
          ),
          radius: 16,
        ),
      ),
      Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          const Text(
            "Menna Ahmed",
            style: TextStyle(color: Colors.black, fontSize: 18),
          ),
          Text(
            "Online                     ",
            style: TextStyle(color: kPrimaryColor, fontSize: 14),
          )
        ],
      ),
    ],
  );
}
