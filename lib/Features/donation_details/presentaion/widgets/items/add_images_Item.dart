import 'package:aid_humanity/Features/donation_details/presentaion/widgets/add_image_widget.dart';
import 'package:aid_humanity/Features/donation_details/presentaion/widgets/textfield_widget.dart';
import 'package:aid_humanity/core/constants/constants.dart';
import 'package:aid_humanity/core/extensions/mediaquery_extension.dart';
import 'package:aid_humanity/core/extensions/translation_extension.dart';
import 'package:aid_humanity/core/widgets/custom_button_widget.dart';
import 'package:aid_humanity/core/widgets/custom_text_widget.dart';
import 'package:flutter/material.dart';

class AddImagesItem extends StatelessWidget {
  const AddImagesItem({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          child: ListView(
            children: [
              Row(
                children: [
                  AddImageWidget(
                    color: kPrimaryColor,
                    icon: Icon(
                      Icons.add_a_photo,
                      color: kPrimaryColor,
                    ),
                  ),
                  AddImageWidget(
                    color: Colors.grey,
                    icon: const Icon(Icons.add_circle),
                  ),
                ],
              ),
              Row(
                children: [
                  AddImageWidget(
                    color: Colors.grey,
                    icon: const Icon(Icons.add_circle),
                  ),
                  AddImageWidget(
                    color: Colors.grey,
                    icon: const Icon(Icons.add_circle),
                  ),
                ],
              ),
            ],
          ),
        ),
        Padding(
          padding: EdgeInsets.only(top: context.getDefaultSize() * 2),
          child: CustomTextWidget(
            fontsize: 3,
            color: Colors.black,
            padding: 0,
            text: context.translate("Enter quantity"),
          ),
        ),
        textFieldDonationDetails(context, "e.g. 10, ..", 15, 2),
        Center(
            child: Padding(
          padding: EdgeInsets.only(bottom: context.getDefaultSize() * 2, top: context.getDefaultSize() * 2),
          child: CustomButtonWidget(height: 6, width: 25, title: "Submit", fontSize: 2.5),
        )),
      ],
    );
  }
}
