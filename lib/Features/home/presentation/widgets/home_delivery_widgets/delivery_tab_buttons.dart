import 'package:aid_humanity/Features/home/domain/use_cases/get_live_requests_usecase.dart';
import 'package:aid_humanity/Features/home/presentation/bloc/home_bloc.dart';
import 'package:aid_humanity/Features/home/presentation/widgets/home_delivery_widgets/card_widget.dart';
import 'package:aid_humanity/core/constants/strings/faliures_strings.dart';
import 'package:aid_humanity/core/extensions/mediaquery_extension.dart';
import 'package:aid_humanity/core/utils/theme/app_color/app_color_light.dart';
import 'package:aid_humanity/core/widgets/faliures_widget.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class DeliveryTabButtons extends StatefulWidget {
  const DeliveryTabButtons({super.key});

  @override
  State<StatefulWidget> createState() => _DeliveryTabButtonsState();
}

class _DeliveryTabButtonsState extends State<DeliveryTabButtons> {
  bool hasLiveRequests = false;
  @override
  void initState() {
    super.initState();
    FirebaseFirestore.instance.collection('request').where('status', isEqualTo: 'inProgress').where('deliveryId', isEqualTo: FirebaseAuth.instance.currentUser!.uid).snapshots().listen((event) {
      if (event.docs.isNotEmpty) {
        setState(() {
          hasLiveRequests = true;
        });
      } else {
        setState(() {
          hasLiveRequests = false;
        });
      }
    });
    BlocProvider.of<HomeBloc>(context).add(GetAllRequestsEvent());
  }

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: () async {
        BlocProvider.of<HomeBloc>(context).add(GetAllRequestsEvent());
      },
      child: Scaffold(
          body: Padding(
        padding: EdgeInsets.only(top: context.getDefaultSize() * 2),
        child: DefaultTabController(
          length: 3,
          child: NestedScrollView(
            headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
              return <Widget>[
                SliverAppBar(
                  backgroundColor: Colors.white,
                  title: const Text('Aid Humanity', style: TextStyle(color: Color(0xFFF8B145))),
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
                  bottom: TabBar(
                    onTap: (index) {
                      if (index == 0) {
                        BlocProvider.of<HomeBloc>(context).add(GetAllRequestsEvent());
                      }
                      if (index == 1) {
                        BlocProvider.of<HomeBloc>(context).add(GetLiveRequestsEvent(userId: FirebaseAuth.instance.currentUser!.uid));
                      }
                    },
                    labelColor: const Color(0xFFF8B145),
                    unselectedLabelColor: Colors.black,
                    physics: const ClampingScrollPhysics(),
                    indicatorColor: const Color(0xFFF8B145),
                    indicatorSize: TabBarIndicatorSize.label,
                    tabs: [
                      const Tab(
                          child: Text(
                        'Requests',
                      )),
                      Tab(
                          child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Text("Live"),
                          const SizedBox(
                            width: 20,
                          ),
                          hasLiveRequests
                              ? Container(
                                  width: 10,
                                  height: 10,
                                  decoration: const BoxDecoration(
                                    color: Colors.green,
                                    shape: BoxShape.circle,
                                  ),
                                )
                              : Container()
                        ],
                      )),
                      const Tab(
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
                BlocConsumer<HomeBloc, HomeState>(
                  listener: (context, state) {
                    if (state is GetAllRequestsFailure && state.message == OFFLINE_FALIURE_MESSAGE) {
                      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(state.message)));
                    }
                  },
                  builder: (context, state) {
                    if (state is GetAllRequestsSuccess) {
                      return ListView.builder(
                        itemCount: state.requests.length,
                        // make scroll in the same position if you are going to another screen and come back
                        key: const PageStorageKey<String>('CardDeliverWidget'),
                        itemBuilder: (context, index) {
                          return CardWidget(
                            requestEntity: state.requests[index],
                          );
                        },
                      );
                    } else if (state is GetAllRequestsFailure) {
                      return RefreshIndicator(
                          onRefresh: () async {
                            BlocProvider.of<HomeBloc>(context).add(GetAllRequestsEvent());
                          },
                          child: FaliureWidget(faliureName: state.message));
                    } else {
                      return const Center(
                        child: CircularProgressIndicator(
                          color: AppColorsLight.primaryColor,
                        ),
                      );
                    }
                  },
                ),
                BlocConsumer<HomeBloc, HomeState>(
                    listener: (context, state) {},
                    builder: (context, state) {
                      if (state is GetLiveRequestsSuccess) {
                        return ListView.builder(
                          itemCount: state.requests.length,
                          // make scroll in the same position if you are going to another screen and come back
                          key: const PageStorageKey<String>('CardDeliverWidget'),
                          itemBuilder: (context, index) {
                            return CardWidget(
                              requestEntity: state.requests[index],
                            );
                          },
                        );
                      } else if (state is GetLiveRequestsFailure) {
                        return RefreshIndicator(
                            onRefresh: () async {
                              BlocProvider.of<HomeBloc>(context).add(GetLiveRequestsEvent(userId: FirebaseAuth.instance.currentUser!.uid));
                            },
                            child: FaliureWidget(faliureName: state.message));
                      } else {
                        return const Center(
                          child: CircularProgressIndicator(
                            color: AppColorsLight.primaryColor,
                          ),
                        );
                      }
                    }),
                ListView.builder(
                  key: const PageStorageKey<String>('Widget'),
                  itemBuilder: (context, index) {
                    return Center(child: const Text("history"));
                  },
                ),
              ],
            ),
          ),
        ),
      )),
    );
  }
}
