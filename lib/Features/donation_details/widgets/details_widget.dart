import 'package:aid_humanity/Features/donation_details/pages/add_images_page.dart';

import 'package:aid_humanity/Features/donation_details/pages/choose_items_page.dart';

import 'package:aid_humanity/core/extensions/mediaquery_extension.dart';
import 'package:aid_humanity/core/utils/constants.dart';

import 'package:aid_humanity/core/widgets/custom_text_widget.dart';
import 'package:flutter/material.dart';

class DetailsWidget extends StatelessWidget {
  const DetailsWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          detailsWidgetButton(
              context,
              "Take",
              "An",
              "Images",
              const TestModel(),
              Icon(
                Icons.add_a_photo_outlined,
                size: context.getDefaultSize() * 4.5,
              )),
          detailsWidgetButton(
              context,
              "Choose",
              "The",
              "Items",
            const ChooseItemsPage(),
              Icon(Icons.photo_library_outlined,
                  size: context.getDefaultSize() * 4.5)),
        ],
      ),
    );
  }

  Padding detailsWidgetButton(BuildContext context, String text1, String text2,
      String text3, Widget page, Icon icon) {
    return Padding(
      padding: EdgeInsets.all(context.getDefaultSize()),
      child: GestureDetector(
        onTap: () => Navigator.push(
            context, MaterialPageRoute(builder: (context) => page)),
        child: Container(
            height: context.getDefaultSize() * 20,
            width: context.getDefaultSize() * 30,
            decoration: BoxDecoration(
                color: Colors.white,
                border: Border.all(
                    color: kPrimaryColor, width: context.getDefaultSize() / 2),
                borderRadius:
                    BorderRadius.circular(context.getDefaultSize() * 2)),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: icon,
                ),
                CustomTextWidget(
                    fontsize: 2.5,
                    color: kPrimaryColor,
                    padding: 0,
                    text: text1),
                CustomTextWidget(
                    fontsize: 2.5,
                    color: kPrimaryColor,
                    padding: 0,
                    text: text2),
                CustomTextWidget(
                    fontsize: 2.5,
                    color: kPrimaryColor,
                    padding: 0,
                    text: text3)
              ],
            )),
      ),
    );
  }
}
