import 'package:aid_humanity/core/extensions/mediaquery_extension.dart';
import 'package:aid_humanity/core/utils/theme/app_color/app_color_light.dart';
import 'package:flutter/material.dart';

class UserSliverAppBar extends StatelessWidget {
  const UserSliverAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      titleTextStyle: const TextStyle(color: Colors.black),
      pinned: true,
      centerTitle: true,
      floating: true,
      expandedHeight: context.getHight() * 0.35,
      backgroundColor: Colors.transparent,
      iconTheme: const IconThemeData(color: AppColorsLight.primaryColor),
      actions: [
        IconButton(onPressed: () {}, icon: const Icon(Icons.camera_alt_rounded)),
      ],
      flexibleSpace: FlexibleSpaceBar(
        centerTitle: true,
        title: const Text(
          "Omar Salama",
          style: TextStyle(color: AppColorsLight.primaryColor),
        ),
        titlePadding: const EdgeInsets.only(left: 10, bottom: 10),
        background: ClipRRect(
            borderRadius: BorderRadius.only(
              bottomRight: Radius.circular(context.getDefaultSize() * 3),
            ),
            child: const Image(image: NetworkImage("https://images.pexels.com/photos/614810/pexels-photo-614810.jpeg?cs=srgb&dl=pexels-simon-robben-614810.jpg&fm=jpg"), fit: BoxFit.fitWidth)),
      ),
    );
  }
}
