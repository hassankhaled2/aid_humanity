import 'package:aid_humanity/Features/chat/pages/chats_pages.dart';
import 'package:aid_humanity/Features/home/presentation/pages/home_delivery_page.dart';
import 'package:aid_humanity/Features/home/presentation/pages/home_donor_page.dart';
import 'package:aid_humanity/Features/profile/presentation/pages/profile_page.dart';
import 'package:flutter/material.dart';

class BottomNavigation extends StatefulWidget {
  const BottomNavigation({Key? key}) : super(key: key);

  @override
  State<BottomNavigation> createState() => _BottomNavigationState();
}

class _BottomNavigationState extends State<BottomNavigation> {
  int currentIndex = 0;

  List<Widget> screens = [const HomeDeliveryPage(), const HomeDonorPage(),  ChatsPage(), const ProfilePage()];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
