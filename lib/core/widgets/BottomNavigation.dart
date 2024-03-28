
import 'package:aid_humanity/Features/home/presentation/bloc/home_bloc.dart';
import 'package:aid_humanity/Features/home/presentation/pages/home_delivery_page.dart';
import 'package:aid_humanity/Features/home/presentation/pages/home_donor_page.dart';
import 'package:aid_humanity/Features/profile/presentation/pages/profile_page.dart';
import 'package:aid_humanity/core/extensions/translation_extension.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class BottomNavigation extends StatefulWidget {
  const BottomNavigation({Key? key}) : super(key: key);

  @override
  State<BottomNavigation> createState() => _BottomNavigationState();
}

class _BottomNavigationState extends State<BottomNavigation> {
  int currentIndex = 0;
  String displayName = "";
  String email = "";
  String photoUrl = "";

  List<Widget> screens = [];

  @override
  void initState() {
    super.initState();
    final user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      displayName = user.displayName ?? "Hassan";
      email = user.email ?? "";
      photoUrl = user.photoURL ?? "https://img.freepik.com/free-vector/man-delivery-package-white-background_1308-46613.jpg?w=740&t=st=1710189458~exp=1710190058~hmac=8976eab32f98feb54f4ae609dfe8eba12acb1a536083a2428ac3b32abb49a967";
      BlocProvider.of<HomeBloc>(context).add(GetAllRequestsEvent());
    }
    screens.addAll([
      const HomeDeliveryPage(),
      const HomeDonorPage(),
      Container(),
      ProfilePage(displayName: displayName, photoUrl: photoUrl, email: email),
    ]);
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
          items:  [
            BottomNavigationBarItem(
              icon: Icon(Icons.home_outlined),
              label: context.translate('Home'),
            ),
            BottomNavigationBarItem(icon: Icon(Icons.location_on_outlined), label: context.translate('Hunger spot')),
            BottomNavigationBarItem(icon: Icon(Icons.chat_outlined), label: context.translate('chat')),
            BottomNavigationBarItem(icon: Icon(Icons.person_outline_rounded), label: context.translate('profile')),
          ]),
    );
  }
}
