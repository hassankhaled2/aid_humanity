import 'dart:io';

import 'package:aid_humanity/Features/donation_details/presentaion/bloc/ai_model_cubit/cubit/classificaiton_cubit.dart';
import 'package:aid_humanity/Features/donation_details/presentaion/bloc/details_bloc.dart';
import 'package:aid_humanity/injection_container.dart';
import 'package:flutter/material.dart';

import 'package:aid_humanity/Features/donation_details/presentaion/items/donation_form_item.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class DonationFormPage extends StatelessWidget {
  const DonationFormPage({
    super.key,
    required this.items,
    required this.itemsImages,
    required this.isKnn
  });
  final isKnn;
  final List<Map<String, dynamic>> items;
  final List<File> itemsImages;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: _buildAppBar(context),
      body: _buildBody(),
    );
  }

  Widget _buildBody() => MultiBlocProvider(providers: [
    BlocProvider(create: (_) => getIt<DetailsBloc>()),
        BlocProvider(create: (_) => ClassificaitonCubit()),
  ],
  child: DonationFormItem(items: items, itemsImages: itemsImages,isKnn: this.isKnn,));
}
