import 'package:aid_humanity/Features/profile/presentation/widgets/user_page_widgets/sava_changes_button_widget.dart';
import 'package:aid_humanity/Features/profile/presentation/widgets/user_page_widgets/sliver_user_form_widget.dart';
import 'package:aid_humanity/Features/profile/presentation/widgets/user_page_widgets/user_sliver_app_bar.dart';
import 'package:aid_humanity/core/extensions/mediaquery_extension.dart';
import 'package:flutter/material.dart';

class UserPageWidget extends StatelessWidget {
  const UserPageWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const Expanded(
          child: CustomScrollView(
            physics: BouncingScrollPhysics(),
            slivers: [
              UserSliverAppBar(),
              SliverPadding(padding: EdgeInsets.all(8.0), sliver: SliverUSerFormWidget()),
            ],
          ),
        ),
        Padding(padding: EdgeInsets.all(context.getDefaultSize() * 1.3), child: const SavaChangesButtonWidget()),
      ],
    );
  }
}
