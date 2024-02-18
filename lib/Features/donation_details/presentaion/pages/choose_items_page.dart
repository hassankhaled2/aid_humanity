import 'package:aid_humanity/Features/donation_details/presentaion/widgets/items/babies_items_item.dart';
import 'package:aid_humanity/Features/donation_details/presentaion/widgets/items/boys_items_item.dart';
import 'package:aid_humanity/Features/donation_details/presentaion/widgets/items/girls_items_item.dart';
import 'package:aid_humanity/Features/donation_details/presentaion/widgets/items/men_items_item.dart';
import 'package:aid_humanity/Features/donation_details/presentaion/widgets/items/women_items_item.dart';
import 'package:aid_humanity/core/constants/constants.dart';
import 'package:aid_humanity/core/extensions/mediaquery_extension.dart';

import 'package:flutter/material.dart';

class ChooseItemsPage extends StatelessWidget {
  const ChooseItemsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
     
      body: Padding(
        padding: EdgeInsets.only(top: context.getDefaultSize() * 2),
        child: DefaultTabController(
          length: 5,
          child: NestedScrollView(
            headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
              return <Widget>[
                SliverAppBar(
                  backgroundColor: Colors.white,
                  title: Text('Choose Items', style: TextStyle(fontWeight: FontWeight.bold, color: Colors.black, fontSize: context.getDefaultSize() * 2)),
                  pinned: true,
                  floating: true,
                  flexibleSpace: FlexibleSpaceBar(
                    background: Container(
                      color: Colors.white,
                    ),
                  ),
                  bottom: TabBar(
                    isScrollable: true,
                    labelColor: kPrimaryColor,
                    unselectedLabelColor: Colors.black,
                    physics: const ClampingScrollPhysics(),
                    indicatorColor: kPrimaryColor,
                    indicatorSize: TabBarIndicatorSize.label,
                    tabs: [
                      Tab(
                          child: Text(
                        'Men',
                        style: TextStyle(fontWeight: FontWeight.bold, fontSize: context.getDefaultSize() * 2.5),
                      )),
                      Tab(
                          child: Text(
                        'Women',
                        style: TextStyle(fontWeight: FontWeight.bold, fontSize: context.getDefaultSize() * 2.5),
                      )),
                      Tab(
                        child: Text(
                          'Boys',
                          style: TextStyle(fontWeight: FontWeight.bold, fontSize: context.getDefaultSize() * 2.5),
                        ),
                      ),
                      Tab(
                        child: Text(
                          'Girls',
                          style: TextStyle(fontWeight: FontWeight.bold, fontSize: context.getDefaultSize() * 2.5),
                        ),
                      ),
                      Tab(
                        child: Text(
                          'Babies',
                          style: TextStyle(fontWeight: FontWeight.bold, fontSize: context.getDefaultSize() * 2.5),
                        ),
                      ),
                    ],
                  ),
                ),
              ];
            },
            body: const TabBarView(
              children: [
                MenItemsItem(),
                WomenItemsItem(),
                BoysItemsItem(),
                GirlsItemsItem(),
                BabiesItemsItem(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
