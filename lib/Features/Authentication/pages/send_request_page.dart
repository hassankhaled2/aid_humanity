import 'package:aid_humanity/Features/Authentication/widgets/request_list_view.dart';

import 'package:aid_humanity/core/extensions/mediaquery_extension.dart';
import 'package:aid_humanity/core/utils/theme/app_color/app_color_light.dart';
import 'package:aid_humanity/core/widgets/custom_divider_widget.dart';
import 'package:flutter/material.dart';

class SendRequestPage extends StatelessWidget {
  const SendRequestPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: context.getDefaultSize() * 3,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.max,
          children: [
            SizedBox(
              height: context.getDefaultSize() * 7,
            ),
            Row(
              children: [
                Text(
                  'Send Request',
                  style: TextStyle(
                    fontSize: context.getDefaultSize() * 3,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            SizedBox(
              height: context.getDefaultSize() * 2.5,
            ),
            const Expanded(
              child: RequestListView(),
            ),
          ],
        ),
      ),
    );
  }
}
