import 'package:aid_humanity/core/extensions/mediaquery_extension.dart';
import 'package:flutter/material.dart';

class SavaChangesButtonWidget extends StatelessWidget {
  const SavaChangesButtonWidget({super.key,});

  @override
  Widget build(BuildContext context) {
    return SizedBox(height: context.getDefaultSize() * 5, width: context.getWidth() * 0.5, child: ElevatedButton(onPressed: ()
    {

    }, child: const Text("Save Changes")));
  }
}
