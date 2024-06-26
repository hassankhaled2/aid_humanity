// ignore_for_file: file_names

import 'package:aid_humanity/Features/home/presentation/pages/home_delivery_page.dart';
import 'package:aid_humanity/Features/profile/presentation/pages/profile_page.dart';
import 'package:aid_humanity/core/extensions/translation_extension.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../Features/home/presentation/bloc/home_bloc.dart';

class BottomNavigationDelivery extends StatefulWidget {
  const BottomNavigationDelivery({Key? key}) : super(key: key);

  @override
  State<BottomNavigationDelivery> createState() =>
      _BottomNavigationDeliveryState();
}

class _BottomNavigationDeliveryState extends State<BottomNavigationDelivery> {
  int currentIndex = 0;

  List<Widget> screens = [
    const HomeDeliveryPage(),
    // const HomeDonorPage(),
    // Container(),
    const ProfilePage()
  ];
  @override
  void initState() {
    BlocProvider.of<HomeBloc>(context).add(GetAllRequestsEvent());

    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //FirebaseAuth.instance.currentUser!.emailVerified?screens[currentIndex]:Container(
      //         width: double.infinity,
      //         child: Padding(
      //           padding: const EdgeInsets.only(top: 40),
      //           child: ElevatedButton(
      //               style: ButtonStyle(backgroundColor: MaterialStatePropertyAll(Color(0xFFF8B145)),shape: MaterialStatePropertyAll(RoundedRectangleBorder(borderRadius:BorderRadius.circular(4))
      //               )),
      //               onPressed: ()
      //               async {
      //
      //                 FirebaseAuth.instance.currentUser!.sendEmailVerification();
      //                 Navigator.of(context).pushNamedAndRemoveUntil(login, (route) => false);
      //
      //               }, child:Text
      //             ('verify your email',style: TextStyle(color: Colors.white),)),
      //         ),
      //       ),
      body: screens[currentIndex],
      bottomNavigationBar: BottomNavigationBar(
          type: BottomNavigationBarType.fixed,
          currentIndex: currentIndex,
          elevation: 70,
          onTap: (index) {
            setState(() {
              currentIndex = index;
            });
          },
          items: [
            BottomNavigationBarItem(
              icon: const Icon(Icons.home_outlined),
              label: context.translate("Home"),
            ),
            // BottomNavigationBarItem(icon: Icon(Icons.location_on_outlined), label: 'Hunger Spot'),
            // BottomNavigationBarItem(icon: Icon(Icons.chat_outlined), label: 'Chat'),
            BottomNavigationBarItem(
                icon: const Icon(Icons.person_outline_rounded),
                label: context.translate('Profile')),
          ]),
    );
  }
}
