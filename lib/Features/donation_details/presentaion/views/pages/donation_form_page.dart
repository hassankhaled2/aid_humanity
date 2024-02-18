import 'package:aid_humanity/Features/donation_details/presentaion/views/items/donation_form_item.dart';
import 'package:flutter/material.dart';
class DonationFormPage extends StatelessWidget {
  const DonationFormPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: _buildAppBar(context),
      body:_buildBody() ,



    );
  }
Widget _buildBody() => const DonationFormItem();
}