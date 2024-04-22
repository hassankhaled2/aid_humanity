import 'dart:io';

import 'package:aid_humanity/Features/auth/presentation/pages/choose_page_google.dart';
import 'package:aid_humanity/Features/auth/presentation/widgets/circle_avatar_google.dart';
import 'package:aid_humanity/core/utils/app_router/app_router.dart';
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';

import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../../core/utils/styles/styles.dart';
import '../widgets/text_form_field.dart';
import 'package:path/path.dart';



class ExtaDataGoogle extends StatefulWidget {
  const ExtaDataGoogle({Key? key, required this.displayName, required this.Email, required this.id}) : super(key: key);
  final String displayName;
  final String Email;
  final String id;
  @override
  State<ExtaDataGoogle> createState() => _State();
}

class _State extends State<ExtaDataGoogle> {
  // TextEditingController lastName = TextEditingController();
  TextEditingController fullName = TextEditingController();
  TextEditingController phone = TextEditingController();
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();
  TextEditingController address = TextEditingController();
  GlobalKey<FormState>formState=GlobalKey();
  bool isloading =true;
  bool isPassword =true;
  CollectionReference categories = FirebaseFirestore.instance.collection('UsersAuth');
  File?select;
  String? url;
  String? _currentAddress;
  Position? _currentPosition;
  // SavePref(String fullName,String phone,String email,String address)async
  // {
  //   SharedPreferences sharedPreference=await SharedPreferences.getInstance();
  //   sharedPreference.setString("fullName", fullName);
  //   sharedPreference.setString("phone" ,phone,);
  //   sharedPreference.setString("email", email);
  //   sharedPreference.setString("address", address);
  //   print("================================================:${sharedPreference.getString("fullName")}");
  //   print(sharedPreference.getString("phone"));
  //   print(sharedPreference.getString("email"));
  //   print(sharedPreference.getString("address"));
  // }
  Future<bool> _handleLocationPermission() async {
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      ScaffoldMessenger.of(context as BuildContext).showSnackBar(const SnackBar(
          content: Text(
              'Location services are disabled. Please enable the services')));
      return false;
    }
    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        ScaffoldMessenger.of(context as BuildContext).showSnackBar(
            const SnackBar(content: Text('Location permissions are denied')));
        return false;
      }
    }
    if (permission == LocationPermission.deniedForever) {
      ScaffoldMessenger.of(context as BuildContext).showSnackBar(const SnackBar(
          content: Text(
              'Location permissions are permanently denied, we cannot request permissions.')));
      return false;
    }
    return true;
  }

  Future<void> _getCurrentPosition() async {
    final hasPermission = await _handleLocationPermission();

    if (!hasPermission) return;
    await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high,)
        .then((Position position) {
      setState(() => _currentPosition = position);
      _getAddressFromLatLng(_currentPosition!);
    }).catchError((e) {
      debugPrint(e);
    });
  }

  Future<void> _getAddressFromLatLng(Position position) async {
    await placemarkFromCoordinates(
        _currentPosition!.latitude, _currentPosition!.longitude)
        .then((List<Placemark> placemarks) {
      Placemark place = placemarks[0];
      setState(() {
        _currentAddress = '${place.street},${place.subAdministrativeArea},${place.administrativeArea},${place.country}';
        address.text=_currentAddress??"";
      });
    }).catchError((e) {
      debugPrint(e);
    });
  }
  SelectAndUploadImage()async {


    final reteurnimage= await ImagePicker().pickImage(source: ImageSource.gallery);
    select=File(reteurnimage!.path);
    var imageName=basename(reteurnimage.path);
    // var refStorage =FirebaseStorage.instance.ref("usersProfile/$imageName");
    var refStorage =FirebaseStorage.instance.ref("usersImages").child(imageName);
    refStorage.putFile(select!);
    url=await refStorage.getDownloadURL();

    setState(() {

    });
  }
@override
  void initState() {
    super.initState();
    _getCurrentPosition();
    // TODO: implement initState
    fullName.text=widget.displayName;
    email.text=widget.Email;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold
      (
      body: Padding(
        padding: const EdgeInsets.only(top: 95,left: 20,right: 20),
        child: ListView(
          children:
          [
            Form(
              key: formState,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children:
                [

                  Padding(
                    padding: EdgeInsets.only(left: 5),
                    child: Text('Contiune Your Data',style: Styles.textStyle25,),
                  ),

                  Padding(
                    padding: EdgeInsets.only(top: 40,),
                    child: CustomTextForm(
                      obscureText: false,
                      mycontroller:fullName ,
                      validator: (val)
                      {
                        if(val=="")
                        {
                          return'can not to be empty';
                        }
                        return null;
                      }, hinttext: 'Full Name',

                    ),

                  ),

                  Padding(
                    padding: const EdgeInsets.only(top: 15),
                    child:CustomTextForm(
                      keyboardType: TextInputType.phone,
                      obscureText: false,

                      hinttext:"+20XXXXXXXXXX" ,
                      mycontroller:phone ,
                      validator: (val)
                      {
                        if(val=="")
                        {
                          return'can not to be empty';
                        }
                        return null;
                      },

                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: 15),
                    child: CustomTextForm(

                      maxLines: 4,
                      obscureText: false,
                      hinttext:"Enter your Address" ,
                      mycontroller:address ,
                      validator: (val)
                      {
                        if(val=="")
                        {
                          return'can not to be empty';
                        }
                        return null;
                      },

                    ),

                  ),
                  Padding(
                    padding: EdgeInsets.only(top: 15,),
                    child: CustomTextForm(
                      obscureText: false,
                      hinttext:"Email" ,
                      mycontroller:email ,
                      validator: (val)
                      {
                        if(val=="")
                        {
                          return'can not to be empty';
                        }
                        return null;
                      },

                    ),

                  ),

                  Padding(
                      padding: const EdgeInsets.only(top: 15,),
                      child: CustomTextForm(
                        obscureText:isPassword,
                        suffix: isPassword?Icons.visibility:Icons.visibility_off,
                        suffixpressed:  ()
                        {
                          setState(() {
                            isPassword=!isPassword;
                          });
                        },
                        hinttext: "Password",
                        mycontroller: password,
                        validator: (val)
                        {
                          if(val=="")
                          {
                            return'can not to be empty';
                          }
                          return null;
                        },


                      )
                  ),
                  const SizedBox(height: 50,),
                  Center(
                    child: Container(
                      height: 35,
                      width: 210,
                      child: ElevatedButton(
                          style: ButtonStyle(backgroundColor: MaterialStatePropertyAll(Colors.black),shape: MaterialStatePropertyAll(RoundedRectangleBorder(borderRadius:BorderRadius.circular(20)))),

                          onPressed: ()

                          async {
                            if(formState.currentState!.validate()) {
                              try {
                                SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
                                String?docgoogle;
                                DocumentReference add=await categories.add({
                                  "Full Name":fullName.text,
                                  "Email":email.text,
                                  "Phone":phone.text,
                                  "Address":address.text,
                                  "LAT":_currentPosition?.latitude??'',
                                  "LNG":_currentPosition?.longitude??'',
                                  // to determine which each user add to firestore that depend on  their ID
                                  "id":widget.id
                                });
                                docgoogle = add.id;
                                sharedPreferences.setString("docGoogle", docgoogle);
                                // addUsersData();
                                Navigator.of(context).push(MaterialPageRoute(builder: (context)
                                {
                                  return CircleAvatarGoogle();
                                }));
                                // Navigator.of(context).pushNamedAndRemoveUntil(AppRouter.circleAvatarProfile, (route) => false);
                                // if(creditional.user!.emailVerified)
                                // {
                                // Navigator.of(context).pushReplacementNamed(bottomNavigation);
                                // }else {
                                //
                                //   AwesomeDialog(
                                //     context: context,
                                //     dialogType: DialogType.error,
                                //     animType: AnimType.rightSlide,
                                //     title: 'Error',
                                //     desc:
                                //     'please go to your gmail and make verify to your email',
                                //   ).show();
                                // }
                                // GoRouter.of(context).push(AppRouter.KBottomNavigation);

                              } on FirebaseAuthException catch (e) {
                                if (e.code ==e.code) {
                                  AwesomeDialog(
                                    context: context,
                                    dialogType: DialogType.error,
                                    animType: AnimType.rightSlide,
                                    title: 'Error',
                                    desc: 'try another email or password',
                                    buttonsTextStyle: const TextStyle(color: Colors.black),
                                    showCloseIcon: true,

                                  ).show();
                                  print('The account already exists for that email.');
                                }
                              } catch (e) {
                                print(e);
                              }
                            }
                          }, child:Text
                        ('Submit')),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
// SizedBox(height: 10,),
// Center(
//   child: InkWell(
//     onTap: ()
//     {
//
//     },
//     child: Ink(
//       color: Color(0xFF397AF3),
//       child: Padding(
//         padding: EdgeInsets.all(6),
//         child: Wrap(
//           crossAxisAlignment: WrapCrossAlignment.center,
//           children: [
//             // Image.asset(AssetsData.googleLogo), // <-- Use 'Image.asset(...)' here
//             SizedBox(width: 12),
//             Text('Sign in with Google'),
//           ],
//         ),
//       ),
//     ),
//   ),
// )
