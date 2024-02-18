import 'package:aid_humanity/Features/home/presentation/widgets/history_widgets/history_item.dart';
import 'package:aid_humanity/core/widgets/defualt_app_bar_widget.dart';
import 'package:flutter/material.dart';

class HistoryPage extends StatelessWidget {
  const HistoryPage({super.key});

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      appBar: _buildAppBar(context),
      body: _buildBody(),
    );
  }
  AppBar _buildAppBar(BuildContext context) => getDefaultAppBarWidget(context: context, title: "History",color: Colors.black,);




  Widget _buildBody() => const HistoryItem();
}