import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../../../../core/widgets/defualt_app_bar_widget.dart';
import '../widgets/home_delivery_widgets/card_delivery_widget.dart';
import '../widgets/home_delivery_widgets/delivery_tab_buttons.dart';

class HomeDeliveryPage extends StatelessWidget {
  const HomeDeliveryPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: _buildAppBar(context),
      body:_buildBody() ,



    );
  }
Widget _buildBody() => const DeliveryTabButtons();

  // AppBar _buildAppBar(BuildContext context) => getDefaultAppBarWidget(
  //         context: context,
  //         title: "Aid Humanity",
  //     color: const Color(0xFFF8B145),
  //     actions: [
  //       IconButton(
  //           onPressed: () {},
  //           icon: const Icon(
  //             FontAwesomeIcons.magnifyingGlass,
  //             color: Colors.black,
  //             size: 20,
  //           )),
  //       IconButton(
  //           onPressed: () {},
  //           icon: const Icon(
  //             Icons.menu,
  //             color: Colors.black,
  //           )),
  //       IconButton(
  //           onPressed: () {},
  //           icon: const Icon(
  //             Icons.notifications,
  //             color: Colors.black,
  //           )),
  //     ]
  // );


}
