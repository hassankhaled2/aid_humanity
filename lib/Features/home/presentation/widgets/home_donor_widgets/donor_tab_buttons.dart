import 'package:aid_humanity/Features/donation_details/presentaion/pages/add_images_page.dart';
import 'package:aid_humanity/Features/donation_details/presentaion/pages/donation_with_text_page.dart';
import 'package:aid_humanity/Features/home/presentation/bloc/home_bloc.dart';
import 'package:aid_humanity/Features/home/presentation/widgets/history_widgets/history_widget.dart';
import 'package:aid_humanity/Features/home/presentation/widgets/card_widget.dart';
import 'package:aid_humanity/core/extensions/translation_extension.dart';
import 'package:aid_humanity/core/utils/constants.dart';
import 'package:aid_humanity/core/extensions/mediaquery_extension.dart';
import 'package:aid_humanity/core/utils/theme/app_color/app_color_light.dart';
import 'package:aid_humanity/core/utils/theme/cubit/theme_cubit.dart';
import 'package:aid_humanity/core/widgets/faliures_widget.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:live_indicator/live_indicator.dart';

class DonorTapButtons extends StatefulWidget {
  const DonorTapButtons({super.key});

  @override
  State<DonorTapButtons> createState() => _DonorTapButtonsState();
}

class _DonorTapButtonsState extends State<DonorTapButtons> {
  bool hasLiveRequests = false;
  @override
  void initState() {
    super.initState();
    FirebaseFirestore.instance
        .collection('request')
        .where('status', isEqualTo: 'inProgress')
        .where('userId', isEqualTo: FirebaseAuth.instance.currentUser!.uid)
        .snapshots()
        .listen((event) {
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
  }

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: () async {
        BlocProvider.of<HomeBloc>(context).add(GetDoneRequestsEvent(
            userId: FirebaseAuth.instance.currentUser!.uid, isDonor: true));
      },
      child: Scaffold(
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
                      title: Text(context.translate('Aid Humanity'),
                          style: const TextStyle(color: Color(0xFFF8B145))),
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
                            BlocProvider.of<HomeBloc>(context).add(
                                GetDoneRequestsEvent(
                                    userId:
                                        FirebaseAuth.instance.currentUser!.uid,
                                    isDonor: true));
                          }
                          if (index == 1) {
                            BlocProvider.of<HomeBloc>(context).add(
                                GetLiveRequestsEvent(
                                    userId:
                                        FirebaseAuth.instance.currentUser!.uid,
                                    isDonor: true));
                          }
                        },
                        labelColor: const Color(0xFFF8B145),
                        unselectedLabelColor: Colors.black,
                        physics: const ClampingScrollPhysics(),
                        indicatorColor: const Color(0xFFF8B145),
                        indicatorSize: TabBarIndicatorSize.label,
                        tabs: [
                          Tab(
                            child: Text(
                              context.translate('History'),
                            ),
                          ),
                          Tab(
                              child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(context.translate("Live")),
                              const SizedBox(
                                width: 20,
                              ),
                              hasLiveRequests ? LiveIndicator(
                                      color: Colors.greenAccent,
                                      spreadRadius: 10,
                                    ) : Container()
                            ],
                          )),
                        ],
                      ),
                    ),
                  ];
                },
                body: TabBarView(
                  children: [
                    BlocConsumer<HomeBloc, HomeState>(
                        listener: (context, state) {},
                        builder: (context, state) {
                          if (state is GetLiveOrDoneRequestsSuccess) {
                            return ListView.builder(
                              itemCount: state.requests.length,
                              // make scroll in the same position if you are going to another screen and come back
                              key: const PageStorageKey<String>(
                                  'CardDeliverWidget'),
                              itemBuilder: (context, index) {
                                return HistoryWidget(
                                  request: state.requests[index],
                                );
                              },
                            );
                          } else if (state is GetLiveOrDoneRequestsFailure) {
                            return RefreshIndicator(
                                onRefresh: () async {
                                  BlocProvider.of<HomeBloc>(context).add(
                                      GetLiveRequestsEvent(
                                          userId: FirebaseAuth
                                              .instance.currentUser!.uid,
                                          isDonor: true));
                                },
                                child:
                                    FaliureWidget(faliureName: state.message));
                          } else {
                            return const Center(
                              child: CircularProgressIndicator(
                                color: AppColorsLight.primaryColor,
                              ),
                            );
                          }
                        }),
                    BlocConsumer<HomeBloc, HomeState>(
                      listener: (context, state) {},
                      builder: (context, state) {
                        if (state is GetLiveOrDoneRequestsLoading) {
                          return const Center(
                              child: CircularProgressIndicator(
                            color: AppColorsLight.primaryColor,
                          ));
                        }
                        if (state is GetLiveOrDoneRequestsSuccess) {
                          return ListView.builder(
                            itemCount: state.requests.length,
                            key: const PageStorageKey<String>(
                                'CardDeliverWidget'),
                            itemBuilder: (context, index) {
                              return CardWidget(
                                requestEntity: state.requests[index],
                                isDonor: true,
                              );
                            },
                          );
                        }
                        if (state is GetLiveOrDoneRequestsFailure) {
                          return FaliureWidget(faliureName: state.message);
                        }
                        return const Center(
                            child: CircularProgressIndicator(
                          color: AppColorsLight.primaryColor,
                        ));
                      },
                    ),
                    // ListView.builder(
                    //   // make scroll in the same position if you are going to another screen and come back
                    //   key: const PageStorageKey<String>('CardDonorWidget'),
                    //   itemBuilder: (context, index) {
                    //     return const CardWidget();
                    //   },
                    // ),
                    // ListView.builder(
                    //   key: const PageStorageKey<String>('Widget'),
                    //   itemBuilder: (context, index) {
                    //     return const CardWidget();
                    //   },
                    // ),
                  ],
                ),
              ),
            )),
        floatingActionButtonLocation:
            BlocProvider.of<ThemeCubit>(context).locale.languageCode == 'en'
                ? FloatingActionButtonLocation.endFloat
                : FloatingActionButtonLocation.startFloat,
        floatingActionButton: floatingActionPoint(),
      ),
    );
  }

  Widget floatingActionPoint() {
    return Builder(builder: (context) {
      return SpeedDial(
        icon: Icons.add,
        activeIcon: Icons.close,
        spacing: 30,
        //openCloseDial: isDialOpen,
        childPadding: const EdgeInsets.all(5),
        spaceBetweenChildren: 20,
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
        childrenButtonSize: const Size.fromRadius(45),
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
            child: const Icon(
              Icons.description_outlined,
              size: 40,
            ),
            backgroundColor: kSecondaryColor,
            foregroundColor: Colors.white,
            label: context.translate("Enter_short_description"),
            labelStyle: TextStyle(fontSize: context.getDefaultSize() * 2),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => (const DonationWithTextPage())),
              );
            },
          ),
          SpeedDialChild(
            child: const Icon(
              Icons.camera_alt_outlined,
              size: 40,
            ),
            backgroundColor: kSecondaryColor,
            foregroundColor: Colors.white,
            label: context.translate("Pick_an_image"),
            labelStyle: TextStyle(fontSize: context.getDefaultSize() * 2),
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
