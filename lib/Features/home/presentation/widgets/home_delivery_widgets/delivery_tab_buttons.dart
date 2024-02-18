import 'package:aid_humanity/Features/home/presentation/widgets/history_widgets/history_widget.dart';
import 'package:aid_humanity/Features/home/presentation/widgets/home_delivery_widgets/card_widget.dart';
import 'package:aid_humanity/core/extensions/mediaquery_extension.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';


class DeliveryTabButtons extends StatelessWidget {
  const DeliveryTabButtons({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:Padding(
        padding:  EdgeInsets.only(top: context.getDefaultSize() * 2),
        child: DefaultTabController(
          length: 3,
          child: NestedScrollView(
            headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
              return <Widget>[
                SliverAppBar(
                  backgroundColor:Colors.white,
                  title: const Text('Aid Humanity',style:TextStyle(color: Color(0xFFF8B145))),
                  actions:
                  [
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
                  flexibleSpace: FlexibleSpaceBar
                    (
                    background: Container(color:Colors.white,),

                  ),
                  bottom: const TabBar(
                    labelColor: Color(0xFFF8B145),
                    unselectedLabelColor: Colors.black,
                    physics: ClampingScrollPhysics(),
                    indicatorColor: Color(0xFFF8B145),
                    indicatorSize: TabBarIndicatorSize.label,
                    tabs: [
                      Tab(child: Text('Requests',)),
                      Tab(child: Text('Live',)),
                      Tab(child: Text('History',),),

                    ],
                  ),
                ),
              ];
            },
            body:   TabBarView(
              children: [
                ListView.builder(
                  // make scroll in the same position if you are going to another screen and come back
                  key: const PageStorageKey<String>('CardDeliverWidget'),
                  itemBuilder: (context, index) {
                    return const CardWidget() ;
                  },

                ),
                ListView.builder(
                  key: const PageStorageKey<String>('CardDeliver'),
                  itemBuilder: (context, index) {
                    return const CardWidget();
                  },


                ),
                ListView.builder(
                  key: const PageStorageKey<String>('Widget'),
                  itemBuilder: (context, index) {
                    return const HistoryWidget();
                  },

                ),
              ],
            ),
          ),
        ),
      )
    );
  }
}
