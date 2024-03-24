import 'package:aid_humanity/Features/profile/presentation/widgets/user_page_widgets/user_page_widget.dart';
import 'package:flutter/material.dart';

class UserInfoPage extends StatelessWidget {
  const UserInfoPage({super.key, required this.fullName, required this.email, required this.phone, required this.address, required this.photoUrl,});
  final String fullName;
  final String email;
  final String phone;
  final String address;
  // final String email;
  final String  photoUrl;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _buildBody(),
    );
  }

  Widget _buildBody() {
    return  UserPageWidget(fullName:fullName ,email:email ,address:address ,phone: phone, photoUrl: photoUrl, );
  }
}
