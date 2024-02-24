import 'package:aid_humanity/Features/home/presentation/bloc/home_bloc.dart';
import 'package:aid_humanity/Features/home/presentation/widgets/home_delivery_widgets/card_widget.dart';
import 'package:aid_humanity/core/constants/strings/faliures_strings.dart';
import 'package:aid_humanity/core/extensions/mediaquery_extension.dart';
import 'package:aid_humanity/core/utils/theme/app_color/app_color_light.dart';
import 'package:aid_humanity/core/widgets/faliures_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class DeliveryTabButtons extends StatefulWidget {
  const DeliveryTabButtons({super.key});

  @override
  State<DeliveryTabButtons> createState() => _DeliveryTabButtonsState();
}

class _DeliveryTabButtonsState extends State<DeliveryTabButtons> {
  @override
  void initState() {
    super.initState();
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
                // ListView.builder(
                //   key: const PageStorageKey<String>('CardDeliver'),
                //   itemBuilder: (context, index) {
                //     return const CardWidget();
                //   },
                // ),
                // ListView.builder(
                //   key: const PageStorageKey<String>('Widget'),
                //   itemBuilder: (context, index) {
                //     return const HistoryWidget();
                //   },
                // ),
              ],
            ),
          ),
        ),
      )),
    );
  }
}
