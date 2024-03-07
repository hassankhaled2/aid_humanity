import 'package:aid_humanity/Features/donation_details/presentaion/bloc/ai_model_cubit/cubit/classificaiton_cubit.dart';
import 'package:aid_humanity/Features/donation_details/presentaion/widgets/add_donation_with_text_widget.dart';
import 'package:aid_humanity/core/widgets/defualt_app_bar_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class DonationWithTextPage extends StatelessWidget {
  const DonationWithTextPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBar(context),
      body: _buildBody(),
    );
  }

  AppBar _buildAppBar(BuildContext context) => getDefaultAppBarWidget(
        context: context,
        title: "Add Description",
        color: Colors.black,
      );

  Widget _buildBody() => BlocProvider(create: (context) => ClassificaitonCubit(), child:  AddDonationWithTextWidget());
}
