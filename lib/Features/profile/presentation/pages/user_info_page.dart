import 'package:aid_humanity/Features/profile/presentation/widgets/user_page_widgets/user_page_widget.dart';
import 'package:flutter/material.dart';

class UserInfoPage extends StatelessWidget {
  const UserInfoPage({super.key, required this.fullName, required this.email, required this.phone, required this.street, required this.photoUrl, required this.region, required this.city, required this.country, required this.flatNumber, required this.floorNumber,});
  final String fullName;
  final String email;
  final String phone;
  final String street;
  final String region;
  final String city;
  final String country;
  final String flatNumber;
  final String floorNumber;
  // final String email;
  final String photoUrl;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _buildBody(),
    );
  }

  Widget _buildBody() {
    return  UserPageWidget(fullName:fullName ,email:email ,street:street ,phone: phone, photoUrl: photoUrl, region:region , city: city, country: country, flatNumber:flatNumber ,floorNumber:floorNumber , );
  }
}
