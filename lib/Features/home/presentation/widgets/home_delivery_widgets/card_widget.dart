
import 'package:aid_humanity/Features/home/presentation/widgets/view_details_widget.dart';
import 'package:aid_humanity/core/entities/request_entity.dart';
import 'package:aid_humanity/core/extensions/mediaquery_extension.dart';
import 'package:aid_humanity/core/widgets/default_elevated_button.dart';
import 'package:flutter/material.dart';


class CardWidget extends StatelessWidget {
  final RequestEntity requestEntity;
  const CardWidget({super.key, required this.requestEntity});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: EdgeInsets.only(
              left: context.getDefaultSize() * 3.4,
              right: context.getDefaultSize() * 3.4,
              bottom: context.getDefaultSize() * 1.4),
          child: Card(
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
            elevation: 3,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  decoration:
                      BoxDecoration(borderRadius: BorderRadius.circular(18)),
                  clipBehavior: Clip.antiAliasWithSaveLayer,
                  width: context.getDefaultSize() * 40,
                  child: Image(
                    height: context.getDefaultSize() * 13,
                    fit: BoxFit.cover,
                    image: NetworkImage(requestEntity.items![0].image),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(
                      left: context.getDefaultSize() * .9,
                      top: context.getDefaultSize() * .8),
                  child: Text(
                    "Donor's Name",
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: context.getDefaultSize() * 2.1),
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                Padding(
                    padding: EdgeInsets.only(
                        left: context.getDefaultSize() * .9,
                        bottom: context.getDefaultSize() * .6),
                    child: Column(
                      children: [
                        Row(
                          children: [
                            Container(
                                height: context.getDefaultSize() * 2.5,
                                width: context.getDefaultSize() * 20,
                                child: ListView(children: [
                                  Text(requestEntity.address["location"])
                                ])),
                            SizedBox(
                              width: context.getDefaultSize() * 3,
                            ),
                            Text(
                              "20 min ago",
                              style: TextStyle(
                                  color: Colors.orange,
                                  height: context.getDefaultSize() * .23,
                                  fontSize: context.getDefaultSize() * 1.5),
                            ),
                          ],
                        )
                      ],
                    )),
                Padding(
                  padding: EdgeInsets.only(
                      left: context.getDefaultSize() * 2,
                      bottom: context.getDefaultSize() * 1),
                  child: Row(
                    children: [
                      SizedBox(
                        width: context.getDefaultSize() * 12,
                      ),
                      DefaultElevatedButton(
                        onPressed: () {
                          Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) => ViewDetailsWidget(
                                    requestEntity: requestEntity,
                                  )));
                        },
                        text: "View Details",
                        radius: 10,
                        height: context.getDefaultSize() * 2.85,
                        width: context.getDefaultSize() * 18,
                      ),
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
