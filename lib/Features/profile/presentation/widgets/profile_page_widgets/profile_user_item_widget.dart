import 'package:aid_humanity/core/extensions/mediaquery_extension.dart';
import 'package:aid_humanity/core/utils/theme/app_color/app_color_light.dart';
import 'package:aid_humanity/core/widgets/custom_divider_widget.dart';
import 'package:flutter/material.dart';

class UserItemWidget extends StatefulWidget {
  const UserItemWidget({super.key,  this.onTap,required this.displayName,required this.photoUrl});
  final Function()? onTap;
  final String displayName;
  final String photoUrl;

  @override
  State<UserItemWidget> createState() => _UserItemWidgetState();
}

class _UserItemWidgetState extends State<UserItemWidget> {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: widget.onTap,
      child: SizedBox(
        width: double.infinity,
        height: context.getDefaultSize() * 6,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const CustomDividerWidget(),
            Expanded(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: context.getDefaultSize() * 1.5),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    CircleAvatar(
                      backgroundImage:  NetworkImage(
                        widget.photoUrl,
                      ),
                      radius: context.getDefaultSize() * 2,
                    ),
                    SizedBox(
                      width: context.getDefaultSize() * 1.2,
                    ),
                    Expanded(
                        child: Column(crossAxisAlignment: CrossAxisAlignment.start, mainAxisAlignment: MainAxisAlignment.center, children: [
                      Text(
                        widget.displayName,
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
                    Icon(Icons.navigate_next_outlined, size: context.getDefaultSize() * 4),
                  ],
                ),
              ),
            ),
            const CustomDividerWidget()
          ],
        ),
      ),
    );
  }
}
