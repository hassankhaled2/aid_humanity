import 'package:aid_humanity/Features/profile/presentation/widgets/user_page_widgets/sava_changes_button_widget.dart';
import 'package:aid_humanity/Features/profile/presentation/widgets/user_page_widgets/sliver_user_form_widget.dart';
import 'package:aid_humanity/Features/profile/presentation/widgets/user_page_widgets/user_sliver_app_bar.dart';
import 'package:aid_humanity/core/extensions/mediaquery_extension.dart';
import 'package:flutter/material.dart';

class UserPageWidget extends StatelessWidget {
  const UserPageWidget({super.key, required this.fullName, required this.email, required this.phone, required this.street, required this.photoUrl, required this.region, required this.city, required this.country, required this.flatNumber, required this.floorNumber,});
  final String fullName;
  final String email;
  final String phone;
  final String street;
  final String region;
  final String city;
  final String country;
  final String photoUrl;
  final String flatNumber;
  final String floorNumber;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
         Expanded(
          child: CustomScrollView(
            physics: BouncingScrollPhysics(),
            slivers: [

              UserSliverAppBar(FullName:fullName, photoUrl: photoUrl, ),
              SliverPadding(padding: EdgeInsets.all(8.0), sliver: SliverUSerFormWidget(fullName: fullName,phone: phone,email: email,street: street, region: region, city: city, country: country, flatNumber:flatNumber,floorNumber: floorNumber,))
            ],
          ),
        ),
        Padding(padding: EdgeInsets.all(context.getDefaultSize() * 1.3), child:  SavaChangesButtonWidget()),
      ],
    );
  }
}
