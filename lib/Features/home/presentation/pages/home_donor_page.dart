
import 'package:aid_humanity/Features/home/presentation/widgets/home_donor_widgets/donor_tab_buttons.dart';
import 'package:flutter/material.dart';

class HomeDonorPage extends StatelessWidget {
  const HomeDonorPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: _buildAppBar(context),
      body: _buildBody(),
    );
  }
  Widget _buildBody() => const DonorTapButtons();

}
