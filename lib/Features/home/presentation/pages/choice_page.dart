import 'package:aid_humanity/Features/home/presentation/widgets/choise_Item.dart';
import 'package:aid_humanity/core/widgets/BottomNavigationDelivery.dart';
import 'package:aid_humanity/core/widgets/BottomNavigationDonor.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
class ChoicePage extends StatefulWidget {
  const ChoicePage({super.key});

  @override
  State<ChoicePage> createState() => _ChoicePageState();
}

class _ChoicePageState extends State<ChoicePage> {
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

  Widget _buildBody() => (userType=="notChoice")?ChoiceItem():(userType=="Donor")?BottomNavigationDonor():BottomNavigationDelivery();
}