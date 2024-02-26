import 'package:flutter/material.dart';

import '../choose_item/choose.dart';
class ChoicePage extends StatelessWidget {
  const ChoicePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _buildBody(),
    );
  }
  Widget _buildBody() => const ChoiceItem();

}