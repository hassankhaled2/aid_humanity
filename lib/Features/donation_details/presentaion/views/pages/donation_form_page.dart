import 'dart:io';

import 'package:aid_humanity/Features/donation_details/presentaion/bloc/details_bloc.dart';
import 'package:aid_humanity/injection_container.dart';
import 'package:flutter/material.dart';

import 'package:aid_humanity/Features/donation_details/presentaion/views/items/donation_form_item.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class DonationFormPage extends StatelessWidget {
  const DonationFormPage({
    super.key,
    required this.items,
    required this.itemsImages,
  });

  final List<String> items;
  final List<File> itemsImages;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: _buildAppBar(context),
      body: _buildBody(),
    );
  }

  Widget _buildBody() => BlocProvider(
        create: (context) => getIt<DetailsBloc>(),
        child: DonationFormItem(items: items, itemsImages: itemsImages),
      );
}
