import 'package:aid_humanity/core/extensions/mediaquery_extension.dart';
import 'package:aid_humanity/core/utils/theme/app_color/app_color_light.dart';
import 'package:flutter/material.dart';
import 'package:flutter_switch/flutter_switch.dart';

class CustomSwitchButton extends StatelessWidget {
  const CustomSwitchButton({super.key});

  @override
  Widget build(BuildContext context) {
    return FlutterSwitch(
      borderRadius: context.getDefaultSize() * 2,
      toggleSize: context.getDefaultSize() * 2,
      showOnOff: true,
      value: true,
      onToggle: (onToggle) {},
      activeColor: Colors.white,
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
