import 'package:aid_humanity/Features/profile/presentation/widgets/user_page_widgets/sava_changes_button_widget.dart';
import 'package:aid_humanity/Features/profile/presentation/widgets/user_page_widgets/sliver_user_form_widget.dart';
import 'package:aid_humanity/Features/profile/presentation/widgets/user_page_widgets/user_sliver_app_bar.dart';
import 'package:aid_humanity/core/extensions/mediaquery_extension.dart';
import 'package:flutter/material.dart';

class UserPageWidget extends StatelessWidget {
  const UserPageWidget({super.key, required this.fullName, required this.email, required this.phone, required this.address, required this.photoUrl,});
  final String fullName;
  final String email;
  final String phone;
  final String address;
  final String  photoUrl;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
         Expanded(
          child: CustomScrollView(
            physics: BouncingScrollPhysics(),
            slivers: [

              UserSliverAppBar(FullName:fullName, photoUrl: photoUrl, ),
              SliverPadding(padding: EdgeInsets.all(8.0), sliver: SliverUSerFormWidget(fullName: fullName,phone: phone,email: email,address: address,))
            ],
          ),
        ),
        Padding(padding: EdgeInsets.all(context.getDefaultSize() * 1.3), child:  SavaChangesButtonWidget()),
      ],
    );
  }
}
