import 'package:aid_humanity/core/extensions/mediaquery_extension.dart';
import 'package:aid_humanity/core/utils/theme/app_color/app_color_light.dart';
import 'package:flutter/material.dart';
import 'package:flutter_switch/flutter_switch.dart';

class CustomSwitchButton extends StatefulWidget {
  const CustomSwitchButton({super.key});

  @override
  State<CustomSwitchButton> createState() => _CustomSwitchButtonState();
}

class _CustomSwitchButtonState extends State<CustomSwitchButton> {
  bool switchStatus = true;
  @override
  Widget build(BuildContext context) {
    return FlutterSwitch(
      borderRadius: context.getDefaultSize() * 2,
      toggleSize: context.getDefaultSize() * 2,
      showOnOff: true,
      value: switchStatus,
      onToggle: (value) {
        value = value;
        setState(() {
          switchStatus = value;
        });
      },
      activeColor: Colors.white,
      duration: const Duration(milliseconds: 10),
      width: context.getDefaultSize() * 5,
      height: context.getDefaultSize() * 2.7,
      inactiveColor: Colors.white,
      inactiveToggleColor: AppColorsLight.primaryColor,
      activeToggleColor: AppColorsLight.primaryColor,
      padding: context.getDefaultSize() * 0.2,
      switchBorder: Border.all(
        color: Colors.grey,
        width: context.getDefaultSize() * 0.1,
      ),
    );
  }
}
