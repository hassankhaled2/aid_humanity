import 'package:aid_humanity/Features/profile/presentation/widgets/user_page_widgets/sava_changes_button_widget.dart';
import 'package:aid_humanity/Features/profile/presentation/widgets/user_page_widgets/sliver_user_form_widget.dart';
import 'package:aid_humanity/Features/profile/presentation/widgets/user_page_widgets/user_sliver_app_bar.dart';
import 'package:aid_humanity/core/extensions/mediaquery_extension.dart';
import 'package:flutter/material.dart';

class UserPageWidget extends StatefulWidget {
  const UserPageWidget({super.key, required this.displayName, required this.email, required this.photoUrl,});
  final String displayName;
  final String email;
  final String  photoUrl;
  @override
  State<UserPageWidget> createState() => _UserPageWidgetState();
}

class _UserPageWidgetState extends State<UserPageWidget> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
         Expanded(
          child: CustomScrollView(
            physics: BouncingScrollPhysics(),
            slivers: [

              UserSliverAppBar(photoUrl:widget.photoUrl ,displayName:widget.displayName ),
              SliverPadding(padding: EdgeInsets.all(8.0), sliver: SliverUSerFormWidget(displayName:widget.displayName,email: widget.email,photoUrl:widget.photoUrl,)),
            ],
          ),
        ),
        Padding(padding: EdgeInsets.all(context.getDefaultSize() * 1.3), child: const SavaChangesButtonWidget()),
      ],
    );
  }
}
