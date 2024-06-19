import 'package:aid_humanity/core/constants/constants.dart';
import 'package:aid_humanity/core/extensions/mediaquery_extension.dart';
import 'package:aid_humanity/core/extensions/translation_extension.dart';
import 'package:aid_humanity/core/utils/app_router/app_router.dart';
import 'package:aid_humanity/core/widgets/custom_button_widget.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
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
class ChoiceItemGoogle extends StatefulWidget {
  const ChoiceItemGoogle({super.key, this.id,});
  final String?id;
  @override
  State<ChoiceItemGoogle> createState() => _ChoiceItemGoogleState();
}

class _ChoiceItemGoogleState extends State<ChoiceItemGoogle> {
  bool pressedDon = false;
  bool pressedDel = false;
  CollectionReference categories = FirebaseFirestore.instance.collection('UsersAuth');

  List<QueryDocumentSnapshot>data=[];
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
              context.translate("Who_are_you?"),
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
                                context.translate("Donor"),
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
                                context.translate("Delivery"),
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

                SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
                String? docGoogle = sharedPreferences.getString("docGoogle");
                print("====================================================================$docGoogle");

                if (pressedDel == true) {
                  setState(() {

                    categories.doc(docGoogle).get().then((docSnapshot) {
                      if (docSnapshot.exists) {
                        Map<String, dynamic> existingData = docSnapshot.data() as Map<String, dynamic>;
                        print("========================================$existingData");


                        categories.doc(docGoogle).update({
                          "userType": "Delivery",
                          "id": FirebaseAuth.instance.currentUser!.uid,
                        });
                      } else {
                        print(context.translate("Document_does_not_exist"));
                      }
                    });


                    sharedPreferences.setString("userType", "Delivery");

                  });

                  print(sharedPreferences.get("userType"));
                  Navigator.of(context).pushNamedAndRemoveUntil(
                      AppRouter.bottomNavigationDelivery, (route) => false);

                } else {
                  setState(() {
                    categories.doc(docGoogle).get().then((docSnapshot) {
                      if (docSnapshot.exists) {

                        Map<String, dynamic> existingData = docSnapshot.data() as Map<String, dynamic>;
                        print("========================================$existingData");


                        categories.doc(docGoogle).update({
                          "userType": "Donor",
                          "id": FirebaseAuth.instance.currentUser!.uid,
                        });
                      } else {
                        print(context.translate("Document_does_not_exist"));
                      }
                    });
                    sharedPreferences.setString("userType", "Donor");
                  });
                  print(sharedPreferences.get("userType"));

                  Navigator.of(context).pushNamedAndRemoveUntil(
                      AppRouter.bottomNavigationDonor, (route) => false);
                }
              },
              child: CustomButtonWidget(
                title: context.translate("Done"),
                fontSize: 2,
                height: 4.3,
                width: 20,
              ),
            ),
          ]),
    );
  }
}
