import 'package:aid_humanity/Features/profile/presentation/widgets/user_page_widgets/text_form_widget.dart';
import 'package:aid_humanity/core/extensions/mediaquery_extension.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
/// handle google sign in details with google sign up
class SliverUSerFormWidget extends StatefulWidget {
   SliverUSerFormWidget({super.key,});
  //  final String FullName;
  // final String email;
  // final String photoUrl;
  //  final String docid;
  //  final String oldname;
  @override
  State<SliverUSerFormWidget> createState() => _SliverUSerFormWidgetState();
}

class _SliverUSerFormWidgetState extends State<SliverUSerFormWidget> {
  List<QueryDocumentSnapshot>data=[];
  bool isloading=true;

  String FullName = '';
  String Email = '';
  String Phone = '';
  String Address = '';
  // String displayName='';
  String photoUrl='';
  CollectionReference categories = FirebaseFirestore.instance.collection("UsersAuth");

  // editCategory() async {
  //
  //
  //       await categories.doc(widget.docid).set({"FullName": FullName,"id":FirebaseAuth.instance.currentUser!.uid});
  //
  //       setState(() {});
  //
  //
  // }
  getdata()async
  {


    // QuerySnapShot --> to can take a data(list of document) from collection
    //FirebaseFirestore.instance.collection("categories").where("id",isEqualTo:FirebaseAuth.instance.currentUser!.uid ).get(); to get the data from firestore that belong to user
    QuerySnapshot querySnapshot=await FirebaseFirestore.instance.collection("UsersAuth").where("id",isEqualTo:FirebaseAuth.instance.currentUser!.uid, ).get();
    //addAll -->Appends all objects of [iterable] to the end of this list
    data.addAll(querySnapshot.docs);
    await Future.delayed(Duration(seconds: 2));
    isloading=false;
    final userData = data.first;
    FullName = userData['Full Name'];
    Email=userData['Email'];
    Phone=userData['Phone'];
    Address=userData['Address'];
    // علشان يعمل رفرش لليوزر انترفيس بعد  ال getdata
    setState(() {

    });
  }

  @override
  void initState() {
      getdata();
 // FullName=widget.oldname;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SliverList(
      delegate: SliverChildListDelegate(
        [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                     'Name',
                      style: TextStyle(fontSize: context.getDefaultSize() * 2, fontWeight: FontWeight.bold),
                    ),
                    SizedBox(
                      height: context.getDefaultSize() * 0.3,
                    ),
                    TextFromWidget(
                      controller: TextEditingController(text: FullName ),
                      obscureText: false,
                      prefixIcon: Icons.person,
                      keyboardType: TextInputType.name,
                      labelText: null,
                    ),
                    SizedBox(
                      height: context.getDefaultSize() * 1.5,
                    ),
                    Text(
                      "Email",
                      style: TextStyle(fontSize: context.getDefaultSize() * 2, fontWeight: FontWeight.bold),
                    ),
                    SizedBox(
                      height: context.getDefaultSize() * 0.3,
                    ),
                    TextFromWidget(
                      controller: TextEditingController(text:Email),
                      obscureText: false,
                      prefixIcon: Icons.email_outlined,
                      keyboardType: TextInputType.emailAddress,
                      labelText: null,
                    ),
                    SizedBox(
                      height: context.getDefaultSize() * 1.5,
                    ),
                    Text(
                      "Phone",
                      style: TextStyle(fontSize: context.getDefaultSize() * 2, fontWeight: FontWeight.bold),
                    ),
                    SizedBox(
                      height: context.getDefaultSize() * 0.3,
                    ),
                    TextFromWidget(
                      controller: TextEditingController(text: Phone),
                      obscureText: false,
                      prefixIcon: Icons.phone_android_outlined,
                      keyboardType: TextInputType.phone,
                      labelText: null,
                    ),
                    SizedBox(
                      height: context.getDefaultSize() * 1.5,
                    ),
                    // Text(
                    //   "Password",
                    //   style: TextStyle(fontSize: context.getDefaultSize() * 2, fontWeight: FontWeight.bold),
                    // ),
                    // SizedBox(
                    //   height: context.getDefaultSize() * 0.3,
                    // ),
                    // TextFromWidget(
                    //   controller: TextEditingController(text: "Omar Salama"),
                    //   obscureText: false,
                    //   prefixIcon: Icons.lock_open_outlined,
                    //   keyboardType: TextInputType.text,
                    //   labelText: null,
                    // ),
                    SizedBox(
                      height: context.getDefaultSize() * 1.5,
                    ),
                    Text(
                      "Address",
                      style: TextStyle(fontSize: context.getDefaultSize() * 2, fontWeight: FontWeight.bold),
                    ),
                    SizedBox(
                      height: context.getDefaultSize() * 0.3,
                    ),
                    TextFromWidget(
                      maxLines: 5,
                      controller: TextEditingController(text:Address),
                      obscureText: false,
                      prefixIcon: Icons.location_on_outlined,
                      keyboardType: TextInputType.text,
                      labelText: null,
                    )
                  ],
                )
              ],
            ),
          ),
          SizedBox(
            height: context.getDefaultSize() * 30,
          ),
        ],
      ),
    );
  }
}
