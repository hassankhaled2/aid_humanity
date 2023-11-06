import 'package:aid_humanity/core/extensions/mediaquery_extension.dart';
import 'package:aid_humanity/core/utils/theme/app_color/app_color_light.dart';
import 'package:flutter/material.dart';

class UserItemWidget extends StatelessWidget {
  const UserItemWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: Row(
        children: [
          CircleAvatar(
            backgroundImage: const NetworkImage(
              "https://images.pexels.com/photos/614810/pexels-photo-614810.jpeg?cs=srgb&dl=pexels-simon-robben-614810.jpg&fm=jpg",
            ),
            radius: context.getDefaultSize() * 2,
          ),
          SizedBox(
            width: context.getDefaultSize() * 1.2,
          ),
          Expanded(
              child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Text(
              "Omar Salama",
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: context.getDefaultSize() * 1.8,
                overflow: TextOverflow.ellipsis,
              ),
            ),
            SizedBox(
              height: context.getDefaultSize() * 0.3,
            ),
            Text(
              "+201234567895",
              style: TextStyle(color: AppColorsLight.primaryColor, fontSize: context.getDefaultSize() * 1.4, overflow: TextOverflow.ellipsis),
            ),
          ])),
          const Spacer(),
          IconButton(onPressed: () {}, icon: Icon(Icons.navigate_next_outlined, size: context.getDefaultSize() * 4)),
        ],
      ),
    );
  }
}
