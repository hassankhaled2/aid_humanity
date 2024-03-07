import 'package:aid_humanity/Features/home/presentation/widgets/choise_Item.dart';
import 'package:flutter/material.dart';
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