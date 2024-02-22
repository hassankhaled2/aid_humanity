
import 'package:aid_humanity/Features/donation_details/presentaion/widgets/data_entry_widgets.dart';
import 'package:aid_humanity/core/widgets/defualt_app_bar_widget.dart';
import 'package:flutter/material.dart';

class DataEntryPage extends StatelessWidget {
  const DataEntryPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBar(context),
      body: _buildBody(),
    );
  }

  AppBar _buildAppBar(BuildContext context) => getDefaultAppBarWidget(
        context: context,
        title: "Donation details",
        color: Colors.black,
      );

  Widget _buildBody() => const DataEntryWidgets();
}
