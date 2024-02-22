import 'package:aid_humanity/Features/home/presentation/pages/home_delivery_page.dart';
import 'package:aid_humanity/Features/profile/presentation/pages/profile_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../utils/app_router/app_router.dart';



class BottomNavigation extends StatefulWidget {
  const BottomNavigation({Key? key}) : super(key: key);

  @override
  State<BottomNavigation> createState() => _BottomNavigationState();
}

class _BottomNavigationState extends State<BottomNavigation> {
  int currentIndex = 0;

  List<Widget> screens = [
    const HomeDeliveryPage(),
    Container(),
    Container(),
    const ProfilePage(),
  ];
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
      body:screens[currentIndex],
      bottomNavigationBar: BottomNavigationBar(
          type: BottomNavigationBarType.fixed,
          currentIndex: currentIndex,
          elevation: 70,
          onTap: (index) {
            setState(() {
              currentIndex = index;
            });
          },
          items: const [
            BottomNavigationBarItem(
              icon: Icon(Icons.home_outlined),
              label: 'Home',
            ),
            BottomNavigationBarItem(icon: Icon(Icons.location_on_outlined), label: 'Hunger Spot'),
            BottomNavigationBarItem(icon: Icon(Icons.chat_outlined), label: 'Chat'),
            BottomNavigationBarItem(icon: Icon(Icons.person_outline_rounded), label: 'Profile'),
          ]),
    );
  }
}
