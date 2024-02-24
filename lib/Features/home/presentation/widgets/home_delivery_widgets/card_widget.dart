import 'package:aid_humanity/core/entities/request_entity.dart';
import 'package:aid_humanity/core/extensions/mediaquery_extension.dart';
import 'package:aid_humanity/core/utils/app_router/app_router.dart';
import 'package:aid_humanity/core/widgets/default_elevated_button.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:go_router/go_router.dart';

class CardWidget extends StatelessWidget {
  final RequestEntity requestEntity;
  const CardWidget({super.key, required this.requestEntity});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: EdgeInsets.only(left: context.getDefaultSize() * 3.4, right: context.getDefaultSize() * 3.4, bottom: context.getDefaultSize() * 1.4),
          child: Card(
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
            elevation: 3,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  decoration: BoxDecoration(borderRadius: BorderRadius.circular(18)),
                  clipBehavior: Clip.antiAliasWithSaveLayer,
                  width: context.getDefaultSize() * 40,
                  child: Image(
                    height: context.getDefaultSize() * 13,
                    fit: BoxFit.cover,
                    image: NetworkImage(requestEntity.items![0].image),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(left: context.getDefaultSize() * .9, top: context.getDefaultSize() * .8),
                  child: Text(
                    "Person's name",
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: context.getDefaultSize() * 2.1),
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                Padding(
                    padding: EdgeInsets.only(left: context.getDefaultSize() * .9, bottom: context.getDefaultSize() * .6),
                    child: Column(
                      children: [
                        Row(
                          children: [
                            Text(requestEntity.address["location"]),
                            SizedBox(
                              width: context.getDefaultSize() * 11,
                            ),
                            Text(
                              "20 min ago",
                              style: TextStyle(color: Colors.orange, height: context.getDefaultSize() * .23, fontSize: context.getDefaultSize() * 1.5),
                            ),
                          ],
                        )
                      ],
                    )),
                Padding(
                  padding: EdgeInsets.only(left: context.getDefaultSize() * 2, bottom: context.getDefaultSize() * 1),
                  child: Row(
                    children: [
                      Icon(
                        FontAwesomeIcons.arrowUpRightFromSquare,
                        size: 12,
                        color: Colors.grey[600],
                      ),
                      SizedBox(
                        width: context.getDefaultSize() * 1,
                      ),
                      Text(
                        "8 km",
                        style: TextStyle(fontSize: context.getDefaultSize() * 1.7, color: Colors.grey[600]),
                      ),
                      SizedBox(
                        width: context.getDefaultSize() * 11,
                      ),
                      DefaultElevatedButton(
                        onPressed: () {
                          GoRouter.of(context).push(AppRouter.kDeliveryViewDetails);
                        },
                        text: "View Details",
                        radius: 10,
                        height: context.getDefaultSize() * 2.85,
                        width: context.getDefaultSize() * 14.2,
                      )
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
