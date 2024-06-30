import 'package:aid_humanity/Features/auth/presentation/widgets/choose_item_google.dart';
import 'package:aid_humanity/core/widgets/BottomNavigationDelivery.dart';
import 'package:aid_humanity/core/widgets/BottomNavigationDonor.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
class ChoicePageGoogle extends StatefulWidget {
  const ChoicePageGoogle({super.key});

  @override
  State<ChoicePageGoogle> createState() => _ChoicePageGoogleState();
}

class _ChoicePageGoogleState extends State<ChoicePageGoogle> {
  String  userType ="notChoice";
  @override
  void initState() {
    super.initState();
    // TODO: implement initState
    getPref();
  }
  getPref()
  async{


    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    if(sharedPreferences.containsKey("userType"))
    {
      setState(() {
        userType= sharedPreferences.getString("userType")!;
      });

    }


    ///donor--->true
    ///delivery-->false
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _buildBody(),
    );
  }

  Widget _buildBody() => (userType=="notChoice")?ChoiceItemGoogle():(userType=="Donor")?BottomNavigationDonor():BottomNavigationDelivery();
}