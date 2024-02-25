import 'package:flutter/material.dart';
import '../widgets/home_delivery_widgets/delivery_tab_buttons.dart';

class HomeDeliveryPage extends StatelessWidget {
  const HomeDeliveryPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: _buildAppBar(context),
      body: _buildBody(),
    );
  }

  Widget _buildBody() => const DeliveryTabButtons();
}
