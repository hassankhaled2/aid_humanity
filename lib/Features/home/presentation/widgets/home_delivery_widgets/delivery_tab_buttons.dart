import 'package:aid_humanity/Features/home/presentation/widgets/history_widgets/history_widget.dart';
import 'package:aid_humanity/Features/home/presentation/widgets/home_delivery_widgets/card_widget.dart';
import 'package:aid_humanity/core/extensions/mediaquery_extension.dart';
import 'package:aid_humanity/core/models/request_model.dart';
import 'package:aid_humanity/core/utils/app_router/app_router.dart';
import 'package:aid_humanity/core/widgets/default_elevated_button.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:go_router/go_router.dart';

class DeliveryTabButtons extends StatefulWidget {
  const DeliveryTabButtons({Key? key}) : super(key: key);

  @override
  State<DeliveryTabButtons> createState() => _DeliveryTabButtonsState();
}

class _DeliveryTabButtonsState extends State<DeliveryTabButtons> {
  List<RequestModel> requests = [];
  bool isLoading = true;
  getData() async {
    final CollectionReference<Map<String, dynamic>> collectionReference =
        FirebaseFirestore.instance.collection('request');
    QuerySnapshot querySnapshot = await collectionReference.get();
    for (QueryDocumentSnapshot queryDocumentSnapshot in querySnapshot.docs) {
      var json = queryDocumentSnapshot.data();
      var requestModel = RequestModel.fromJson(json as Map<String, dynamic>);
      print(requestModel);
      requests.add(requestModel);
    }

    isLoading = false;
    setState(() {});
  }

  @override
  void initState() {
    getData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Padding(
      padding: EdgeInsets.only(top: context.getDefaultSize() * 2),
      child: DefaultTabController(
        length: 3,
        child: NestedScrollView(
          headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
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
                      'Requests',
                    )),
                    Tab(
                        child: Text(
                      'Live',
                    )),
                    Tab(
                      child: Text(
                        'History',
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
                itemCount: requests.length,
                key: const PageStorageKey<String>('CardDeliverWidget'),
                itemBuilder: (context, index) {
                  return Card(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12)),
                    elevation: 3,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(18)),
                          clipBehavior: Clip.antiAliasWithSaveLayer,
                          width: context.getDefaultSize() * 40,
                          child: Image(
                            height: context.getDefaultSize() * 13,
                            fit: BoxFit.cover,
                            image: const NetworkImage(
                                "https://www.thfashions.org/wp-content/uploads/2022/07/GettyImages-1342605876-640x372.jpg"),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(
                              left: context.getDefaultSize() * .9,
                              top: context.getDefaultSize() * .8),
                          child: Text(
                            "Person's name",
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: context.getDefaultSize() * 2.1),
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                        Padding(
                            padding: EdgeInsets.only(
                                left: context.getDefaultSize() * .9,
                                bottom: context.getDefaultSize() * .6),
                            child: Column(
                              children: [
                                Row(
                                  children: [
                                    Text("{}"),
                                    SizedBox(
                                      width: context.getDefaultSize() * 11,
                                    ),
                                    Text(
                                      "20 min ago",
                                      style: TextStyle(
                                          color: Colors.orange,
                                          height:
                                              context.getDefaultSize() * .23,
                                          fontSize:
                                              context.getDefaultSize() * 1.5),
                                    ),
                                  ],
                                )
                              ],
                            )),
                        Padding(
                          padding: EdgeInsets.only(
                              left: context.getDefaultSize() * 2,
                              bottom: context.getDefaultSize() * 1),
                          child: Row(
                            children: [
                              Icon(
                                FontAwesomeIcons.arrowUpRightFromSquare,
                                size: 12,
                                color: Colors.grey[600],
                              ),
                              SizedBox(
                                width: context.getDefaultSize() * 1,
                              ),
                              Text(
                                "8 km",
                                style: TextStyle(
                                    fontSize: context.getDefaultSize() * 1.7,
                                    color: Colors.grey[600]),
                              ),
                              SizedBox(
                                width: context.getDefaultSize() * 11,
                              ),
                              DefaultElevatedButton(
                                onPressed: () {
                                  GoRouter.of(context)
                                      .push(AppRouter.kDeliveryViewDetails);
                                },
                                text: "View Details",
                                radius: 10,
                                height: context.getDefaultSize() * 2.85,
                                width: context.getDefaultSize() * 14.2,
                              )
                            ],
                          ),
                        ),
                      ],
                    ),
                  );
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
    ));
  }
}
