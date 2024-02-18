import 'package:aid_humanity/Features/donation_details/presentaion/views/pages/add_images_page.dart';
import 'package:aid_humanity/Features/donation_details/presentaion/views/pages/choose_items_page.dart';
import 'package:aid_humanity/Features/donation_details/presentaion/views/pages/data_entry_page.dart';
import 'package:aid_humanity/Features/home/presentation/widgets/home_delivery_widgets/card_widget.dart';
import 'package:aid_humanity/core/utils/constants.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:aid_humanity/core/extensions/mediaquery_extension.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class DonorTapButtons extends StatefulWidget {
  const DonorTapButtons({super.key});

  @override
  State<DonorTapButtons> createState() => _DonorTapButtonsState();
}

class _DonorTapButtonsState extends State<DonorTapButtons> {


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
          padding: EdgeInsets.only(top: context.getDefaultSize() * 2),
          child: DefaultTabController(
            length: 2,
            child: NestedScrollView(
              headerSliverBuilder:
                  (BuildContext context, bool innerBoxIsScrolled) {
                return <Widget>[
                  SliverAppBar(
                    backgroundColor: Colors.white,
                    title: const Text('Aid Humanity',
                        style: TextStyle(color: Color(0xFFF8B145))),
                    actions: [
                      IconButton(
                          onPressed: () {},
                          icon: const Icon(
                            FontAwesomeIcons.magnifyingGlass,
                            color: Colors.black,
                            size: 20,
                          )),
                      IconButton(
                          onPressed: () {},
                          icon: const Icon(
                            Icons.notifications,
                            color: Colors.black,
                          )),
                    ],
                    pinned: true,
                    floating: true,
                    flexibleSpace: FlexibleSpaceBar(
                      background: Container(
                        color: Colors.white,
                      ),
                    ),
                    bottom: const TabBar(
                      labelColor: Color(0xFFF8B145),
                      unselectedLabelColor: Colors.black,
                      physics: ClampingScrollPhysics(),
                      indicatorColor: Color(0xFFF8B145),
                      indicatorSize: TabBarIndicatorSize.label,
                      tabs: [
                        Tab(
                            child: Text(
                          'History',
                        )),
                        Tab(
                          child: Text(
                            'Live',
                          ),
                        ),
                      ],
                    ),
                  ),
                ];
              },
              body: TabBarView(
                children: [
                  ListView.builder(
                    // make scroll in the same position if you are going to another screen and come back
                    key: const PageStorageKey<String>('CardDonorWidget'),
                    itemBuilder: (context, index) {
                      return const CardWidget();
                    },
                  ),
                  ListView.builder(
                    key: const PageStorageKey<String>('Widget'),
                    itemBuilder: (context, index) {
                      return const CardWidget();
                    },
                  ),
                ],
              ),
            ),
          )),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
      floatingActionButton: floatingActionPoint(),
    );
  }

  Widget floatingActionPoint() {
    return Builder(builder: (context) {
      return SpeedDial(
        icon: Icons.add,
        activeIcon: Icons.close,
        spacing: 3,
        //openCloseDial: isDialOpen,
        childPadding: const EdgeInsets.all(5),
        spaceBetweenChildren: 4,
        //.....
        buttonSize: const Size.fromRadius(
            35), //speedDial size which defaults to 56 itself
        //iconTheme:IconThemeData(size:22),
        /*label:
            extend ? const Text("Open") : null, //the label of the main button
        ///the active  label of the main button, defaults to label if not specified,
        activeLabel: extend ? const Text("Close") : null,*/

        ///transition builder between label and active label, default
        // labelTransitionBuilder: (widget,animation)=>ScaleTransition(scale: double),
        childrenButtonSize: const Size.fromRadius(40),
        visible: true,
        direction: SpeedDialDirection.up,
        switchLabelPosition: false,
        //closeManually: false,
        //if false, backgroundOverlay will not be rendered
        renderOverlay: true,
        overlayColor: Colors.black,
        overlayOpacity: 0.5,
        onOpen: () => debugPrint("OPENING DIAL"),
        onClose: () => debugPrint("DIAL CLOSED"),
        useRotationAnimation: true,
        foregroundColor: Colors.black,
        backgroundColor: Colors.white,
        //activeForegroundColor: Colors.red,
        //activeBackgroundColor: Colors.blue,
        elevation: 8.0,
        animationCurve: Curves.elasticInOut,
        //isOpenOnStart: false,
        //animationDuration: const Duration(milliseconds: 500),
        //shape: customDialRoot,
        // ?const RoundedRectangleBorder()
        // :const StadiumBorder(),
        // childMargin: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
        children: [
          SpeedDialChild(
            child: const Icon(Icons.description_outlined),
            backgroundColor: kSecondaryColor,
            foregroundColor: Colors.white,
            label: "Enter short description",
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => (const DataEntryPage())),
              );
            },
          ),
          SpeedDialChild(
            child: const Icon(Icons.photo_album_outlined),
            backgroundColor: kSecondaryColor,
            foregroundColor: Colors.white,
            label: "Choose the items",
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => (const ChooseItemsPage())),
              );
            },
          ),
          SpeedDialChild(
            child: const Icon(Icons.camera_alt_outlined),
            backgroundColor: kSecondaryColor,
            foregroundColor: Colors.white,
            label: "Pick an image",
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => (const AddImagePage())),
              );
            },
          )
        ],
      );
    });
  }
}
