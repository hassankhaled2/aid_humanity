import 'package:aid_humanity/core/widgets/custom_switch_button.dart';
import 'package:aid_humanity/core/extensions/mediaquery_extension.dart';
import 'package:flutter/material.dart';

class ProfileItemWidget extends StatelessWidget {
  final IconData icon;
  final Color? iconColor;
  final String text;
  final bool isModeWidget;
  const ProfileItemWidget({super.key, required this.icon, required this.text, required this.isModeWidget, this.iconColor = Colors.black});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: context.getDefaultSize() * 4,
      child: Row(
        children: [
          Icon(
            icon,
            color: iconColor,
            size: context.getDefaultSize() * 1.9,
          ),
          SizedBox(
            width: context.getDefaultSize(),
          ),
          Text(
            text,
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: context.getDefaultSize() * 1.6,
            ),
          ),
          const Spacer(),
          isModeWidget ? const CustomSwitchButton() : IconButton(onPressed: () {}, icon: Icon(Icons.navigate_next_outlined, size: context.getDefaultSize() * 3)),
        ],
      ),
    );
  }
}
