import 'package:aid_humanity/core/extensions/mediaquery_extension.dart';
import 'package:aid_humanity/core/utils/theme/app_color/app_color_light.dart';
import 'package:flutter/material.dart';

class UserSliverAppBar extends StatefulWidget {
  const UserSliverAppBar({super.key, required this.displayName, required this.photoUrl});
  final String displayName;
  final String photoUrl;

  @override
  State<UserSliverAppBar> createState() => _UserSliverAppBarState();
}

class _UserSliverAppBarState extends State<UserSliverAppBar> {
  @override
  void initState() {

    super.initState();
  }
///delete this
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
        title:  Text(
          widget.displayName,
          style: TextStyle(color: AppColorsLight.primaryColor),
        ),
        titlePadding: const EdgeInsets.only(left: 10, bottom: 10),
        background: ClipRRect(
            borderRadius: BorderRadius.only(
              bottomRight: Radius.circular(context.getDefaultSize() * 3),
            ),
            child:  Image.network(widget.photoUrl,fit: BoxFit.fill, errorBuilder: (context, error, stackTrace) =>  const Center(child: CircularProgressIndicator(color: Colors.orangeAccent,)),),
      ),
      ),
    );
  }
}
