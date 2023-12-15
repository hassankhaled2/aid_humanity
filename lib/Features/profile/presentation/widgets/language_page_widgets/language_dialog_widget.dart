import 'package:aid_humanity/core/extensions/mediaquery_extension.dart';
import 'package:aid_humanity/core/utils/theme/app_color/app_color_light.dart';
import 'package:aid_humanity/core/widgets/custom_divider_widget.dart';
import 'package:flutter/material.dart';

class LangageDialogWidget extends StatefulWidget {
  const LangageDialogWidget({super.key});

  @override
  State<LangageDialogWidget> createState() => _LangageDialogWidgetState();
}

class _LangageDialogWidgetState extends State<LangageDialogWidget> {
  int selectedValue = 1;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: context.getDefaultSize() * 13,
      width: context.getDefaultSize() * 38,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const CustomDividerWidget(thickness: 1.0, whiteSpaceBegin: 15),
          ListTile(
            title: const Text(
              "English",
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            trailing: Radio<int>(
              value: 1,
              groupValue: selectedValue,
              onChanged: (value) {
                setState(() {
                  selectedValue = value!;
                });
              },
              fillColor: MaterialStateProperty.all(AppColorsLight.primaryColor),
              toggleable: true,
            ),
          ),
          const CustomDividerWidget(thickness: 1.0, whiteSpaceBegin: 15),
          ListTile(
            title: const Text("العربية", style: TextStyle(fontWeight: FontWeight.bold)),
            trailing: Radio<int>(
              value: 2,
              groupValue: selectedValue,
              onChanged: (value) {
                setState(() {
                  selectedValue = value!;
                });
              },
              fillColor: MaterialStateProperty.all(AppColorsLight.primaryColor),
              toggleable: true,
            ),
          ),
        ],
      ),
    );
  }
}
