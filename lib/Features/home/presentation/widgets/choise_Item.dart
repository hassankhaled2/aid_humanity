import 'package:aid_humanity/Features/home/presentation/pages/home_delivery_page.dart';
import 'package:aid_humanity/Features/home/presentation/pages/home_donor_page.dart';
import 'package:aid_humanity/core/constants/constants.dart';
import 'package:aid_humanity/core/extensions/mediaquery_extension.dart';
import 'package:aid_humanity/core/utils/app_router/app_router.dart';
import 'package:aid_humanity/core/widgets/BottomNavigationDelivery.dart';
import 'package:aid_humanity/core/widgets/BottomNavigationDonor.dart';
import 'package:aid_humanity/core/widgets/custom_button_widget.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

///important code bottom
///--------
//import 'package:cloud_firestore/cloud_firestore.dart';
//
// Future<void> saveUserChoiceToFirestore(String role) async {
//   final userRef = FirebaseFirestore.instance.collection('users').doc(FirebaseAuth.instance.currentUser!.uid);
//   await userRef.update({'role': role});
// }
//
// Future<String?> getUserChoiceFromFirestore() async {
//   final userRef = FirebaseFirestore.instance.collection('users').doc(FirebaseAuth.instance.currentUser!.uid);
//   final snapshot = await userRef.get();
//   return snapshot.data()?['role'];
// }
//
// // In ChoiceItem's onTap handlers:
// if (pressedDel == true) {
//   saveUserChoiceToFirestore('Delivery');
//   Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => BottomNavigationDelivery()));
// } else {
//   saveUserChoiceToFirestore('Donor');
//   Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => BottomNavigationDonor()));
// }
///---------
class ChoiceItem extends StatefulWidget {
  const ChoiceItem({super.key});

  @override
  State<ChoiceItem> createState() => _ChoiceItemState();
}

class _ChoiceItemState extends State<ChoiceItem> {
  bool pressedDon = false;
  bool pressedDel = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(
              height: context.getDefaultSize() * 20,
            ),
            Text(
              "Who are you ?",
              style: TextStyle(
                  color: Colors.black,
                  fontSize: context.getDefaultSize() * 3,
                  fontWeight: FontWeight.bold),
            ),
            SizedBox(
              height: context.getDefaultSize() * 6,
            ),
            Padding(
              padding: EdgeInsets.all(context.getDefaultSize() * 2),
              child: Row(
                children: [
                  Card(
                    elevation: context.getDefaultSize() * 2,
                    child: GestureDetector(
                      onTap: () {
                        // SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
                        // sharedPreferences.setString("userType","Donor");
                        setState(() {
                          pressedDon = true;
                          pressedDel = false;
                        });
                      },
                      child: Container(
                          height: context.getDefaultSize() * 16,
                          width: context.getDefaultSize() * 16,
                          decoration: BoxDecoration(
                            color: pressedDon
                                ? kPrimaryColor
                                : Colors.white.withOpacity(0.7),
                            borderRadius: BorderRadiusDirectional.circular(
                                context.getDefaultSize() * 2),
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Icon(
                                Icons.volunteer_activism,
                                color:
                                    pressedDon ? Colors.white : kPrimaryColor,
                                size: context.getDefaultSize() * 6,
                              ),
                              SizedBox(
                                height: context.getDefaultSize() * 2,
                              ),
                              Text(
                                "Donor",
                                style: TextStyle(
                                    color: pressedDon
                                        ? Colors.white
                                        : kPrimaryColor,
                                    fontSize: context.getDefaultSize() * 2,
                                    fontWeight: FontWeight.bold),
                              ),
                            ],
                          )),
                    ),
                  ),
                  SizedBox(
                    width: context.getDefaultSize() * 3,
                  ),
                  Card(
                    elevation: context.getDefaultSize() * 2,
                    child: GestureDetector(
                      onTap: () {
                        setState(() {
                          pressedDel = true;
                          pressedDon = false;
                        });
                      },
                      child: Container(
                          height: context.getDefaultSize() * 16,
                          width: context.getDefaultSize() * 16,
                          decoration: BoxDecoration(
                            color: pressedDel
                                ? kPrimaryColor
                                : Colors.white.withOpacity(0.7),
                            borderRadius: BorderRadiusDirectional.circular(
                                context.getDefaultSize() * 2),
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Icon(
                                Icons.delivery_dining,
                                color:
                                    pressedDel ? Colors.white : kPrimaryColor,
                                size: context.getDefaultSize() * 6,
                              ),
                              SizedBox(
                                height: context.getDefaultSize() * 2,
                              ),
                              Text(
                                "Delivery",
                                style: TextStyle(
                                    color: pressedDel
                                        ? Colors.white
                                        : kPrimaryColor,
                                    fontSize: context.getDefaultSize() * 2,
                                    fontWeight: FontWeight.bold),
                              ),
                            ],
                          )),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: context.getDefaultSize() * 18,
            ),
            GestureDetector(
              onTap: () async {
                SharedPreferences sharedPreferences =
                    await SharedPreferences.getInstance();
                if (pressedDel == true) {
                  setState(() {
                    sharedPreferences.setString("userType", "Delivery");
                  });
                  print(sharedPreferences.get("userType"));
                  Navigator.of(context).pushNamedAndRemoveUntil(
                      AppRouter.bottomNavigationDelivery, (route) => false);
                } else {
                  setState(() {
                    sharedPreferences.setString("userType", "Donor");
                  });
                 print(sharedPreferences.get("userType"));
                  Navigator.of(context).pushNamedAndRemoveUntil(
                      AppRouter.bottomNavigationDonor, (route) => false);
                }
              },
              child: CustomButtonWidget(
                title: "Done",
                fontSize: 2,
                height: 4.3,
                width: 20,
              ),
            ),
          ]),
    );
  }
}
