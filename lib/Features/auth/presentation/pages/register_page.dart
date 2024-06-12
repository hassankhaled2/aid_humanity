import 'dart:io';
import 'package:aid_humanity/core/extensions/mediaquery_extension.dart';
import 'package:aid_humanity/core/utils/app_router/app_router.dart';
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fancy_shimmer_image/fancy_shimmer_image.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../../core/constants/constants.dart';
import '../../../../core/constants/test.dart';
import '../../../../core/utils/styles/styles.dart';
import '../bloc/auth_bloc.dart';
import '../widgets/text_form_field.dart';
import 'extra_data_google.dart';
import 'login_page.dart';
import 'package:path/path.dart';



class RegisterPage extends StatefulWidget {
  const RegisterPage({Key? key}) : super(key: key);

  @override
  State<RegisterPage> createState() => _State();
}

class _State extends State<RegisterPage> {
  TextEditingController fullName = TextEditingController();
  // TextEditingController lastName = TextEditingController();
  TextEditingController phone = TextEditingController();
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();
  TextEditingController currentStreet = TextEditingController();

  TextEditingController street = TextEditingController();
  TextEditingController region = TextEditingController();
  TextEditingController city = TextEditingController();
  TextEditingController country = TextEditingController();
  TextEditingController floorNumber = TextEditingController();
  TextEditingController flatNumber = TextEditingController();
  GlobalKey<FormState>formState=GlobalKey();
  bool isloading =true;
  bool isPassword =true;
  CollectionReference categories = FirebaseFirestore.instance.collection('UsersAuth');

  File?select;
  String? url;

  String? _currentStreet;
  String? _region;
  String? _city;
  String? _country;

  Position? _currentPosition;

  SelectAndUploadImage()async {


    final reteurnimage= await ImagePicker().pickImage(source: ImageSource.gallery);
    select=File(reteurnimage!.path);
    var imageName=basename(reteurnimage.path);
    // var refStorage =FirebaseStorage.instance.ref("usersProfile/$imageName");
    var refStorage =FirebaseStorage.instance.ref("usersImages").child(imageName);
    refStorage.putFile(select!);

    url=await refStorage.getDownloadURL();
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    sharedPreferences.setString("userImage",url!);
    setState(() {

    });
  }
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
        _currentStreet = '${place.street}';
        _region ='${place.subAdministrativeArea}';
        _city='${place.administrativeArea}';
        _country='${place.country}';

        street.text=_currentStreet??"";
        region.text=_region??'';
        city.text=_city??'';
        country.text=_country??'';
      });
    }).catchError((e) {
      debugPrint(e);
    });
  }
  @override
  void initState() {
    super.initState();
    _getCurrentPosition();


  }

  // SelectAndUploadImage()async {
  //
  //
  //   final reteurnimage= await ImagePicker().pickImage(source: ImageSource.gallery);
  //   select=File(reteurnimage!.path);
  //   var imageName=basename(reteurnimage.path);
  //   // var refStorage =FirebaseStorage.instance.ref("usersProfile/$imageName");
  //   var refStorage =FirebaseStorage.instance.ref("usersImages").child(imageName);
  //   refStorage.putFile(select!);
  //   url=await refStorage.getDownloadURL();
  //
  //   setState(() {
  //
  //   });
  // }
  // addUsersData() async{
  //   if(formState.currentState!.validate()) {
  //     try {
  //       isloading=true;
  //       setState(() {
  //
  //       });
  //       //???
  //
  //       // Navigator.of(context).pushReplacementNamed('homepage');
  //       // // if process done right , print for me (.....)
  //       // .then((value) => print("User Added"))
  //       // //not run right, print for me (.....)
  //       // .catchError((error) => print("Failed to add user: $error"));
  //     }catch(e)
  //     {
  //       isloading=false;
  //       setState(() {
  //
  //       });
  //       print('Error $e');
  //     }
  //   }
  //   // Call the user's CollectionReference to add a new user
  //
  // }

  Future signInWithGoogle(BuildContext context) async {
    // final user=FirebaseAuth.instance.currentUser;
    final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

    GoogleSignInAuthentication?googleAuth = await googleUser?.authentication;

    // Create a new credential
    final credential = GoogleAuthProvider.credential(

      accessToken: googleAuth?.accessToken,
      idToken: googleAuth?.idToken,
    );
    // Once signed in, return the UserCredential
   final userCredential = await FirebaseAuth.instance.signInWithCredential(credential);
    final id = userCredential.user!.uid;
    final user = userCredential.user!;
    final displayName = user.displayName ?? 'hahadhda';
    final email = user.email ?? 'hdahdhah';
   Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (context)
   {
     return  ExtaDataGoogle(displayName: displayName, Email:email , id: id);
   }), (route) => false);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold
      (
      body: Padding(
        padding: EdgeInsets.all(context.getDefaultSize()*2),
        child: ListView(
          children:
          [
            Form(
              key: formState,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children:
                [

                  SizedBox(height: context.getDefaultSize()*1,),
                  const Text('Sign Up',style: Styles.textStyle25,),
                  SizedBox(height: context.getDefaultSize()*1.5,),
                  Center(
                    child: Stack(
                      clipBehavior: Clip.none, // Clip overflowing widgets
                      children: [
                        CircleAvatar(

                          radius:context.getDefaultSize() * 6 ,
                          child: url == null
                              ? Text('')
                              : ClipOval(
                            child: FancyShimmerImage(
                              imageUrl: url!,
                              shimmerDuration: Duration(seconds: 2),
                              boxFit: BoxFit.fill,
                              width: context.getDefaultSize() * 20,
                              height: context.getDefaultSize() * 20,
                              shimmerBaseColor: Colors.grey,
                              shimmerHighlightColor: Colors.white,
                            ),
                          ),
                        ),
                        Positioned(
                          right: context.getDefaultSize() * 0.2, // Adjust positioning as needed
                          bottom:context.getDefaultSize() * 0, // Adjust positioning as needed
                          child: Container(
                            height: context.getDefaultSize() * 3.5,
                            width: context.getDefaultSize() * 3.5,
                            decoration: BoxDecoration(
                              color: kPrimaryColor, // Change color as desired
                              shape: BoxShape.circle,
                            ),
                            child: IconButton(
                              icon: Icon(
                                Icons.add,
                                size: context.getDefaultSize() * 2,
                                color: Colors.white,
                              ),
                              onPressed:()
                              {
                                SelectAndUploadImage();
                                // ProfilePage(k: url!);

                              },
                            ),
                          ),
                        ),
                        // ElevatedButton(onPressed: ()
                        // {
                        //   Navigator.of(context).push(MaterialPageRoute(builder: (context)
                        //   {
                        //     return ProfilePage(k: url!,);
                        //   }));
                        // }, child:Text("nh")
                        // )
                        // ProfilePage(k:url!),
                      ],
                    ),
                  ),
                  SizedBox(height: context.getDefaultSize()*4,),
                  CustomTextForm(
                    obscureText: false,
                    hinttext:"Full Name" ,
                    mycontroller:fullName ,
                    validator: (val)
                    {
                      if(val=="")
                      {
                        return'can not to be empty';
                      }
                      return null;
                    },

                  ),
                  SizedBox(height: context.getDefaultSize()*1.6,),
                  CustomTextForm(
                    keyboardType: TextInputType.phone,
                    // inputFormatters: [
                    //   FilteringTextInputFormatter.digitsOnly

                    // prefixIcon: CountryCodePicker(
                    //   onChanged: (CountryCode countryCode) {},
                    //   initialSelection: 'EG',
                    //   showFlag: true,
                    //   favorite: const ['+20', 'EG'],
                    //   showCountryOnly: false,
                    //   showOnlyCountryWhenClosed: false,
                    //   alignLeft: false,
                    //   showDropDownButton: true,
                    //   padding: EdgeInsets.zero,
                    // ),                      // inputFormatters:
                    // [
                    //   FilteringTextInputFormatter.allow(RegExp(r'^\-?(\d+\.?\d{0,2})?')),
                    // ],
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
                  SizedBox(height: context.getDefaultSize()*1.6,),
                  Row(
                    children: [
                      SizedBox(
                        width:context.getDefaultSize()*18 ,
                        child: CustomTextForm(
                          // isDeny: true,
                          maxLines: 1,
                          obscureText: false,
                          hinttext:"No.StreetName" ,
                          mycontroller:street,
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
                      SizedBox(width: context.getDefaultSize()*1,),
                      SizedBox(
                        width:context.getDefaultSize()*18 ,
                        child: CustomTextForm(
                          maxLines: 1,
                          obscureText: false,
                          hinttext:"region" ,
                          mycontroller:region,
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
                    ],
                  ),
                  SizedBox(height: context.getDefaultSize()*1,),
                  Row(
                    children: [
                      SizedBox(
                        width:context.getDefaultSize()*25,
                        child: CustomTextForm(
                          maxLines: 1,
                          obscureText: false,
                          hinttext:"City" ,
                          mycontroller:city,
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
                      SizedBox(width: context.getDefaultSize()*1,),
                      SizedBox(
                        width:context.getDefaultSize()*11 ,
                        child: CustomTextForm(
                          maxLines: 1,
                          obscureText: false,
                          hinttext:"country" ,
                          mycontroller:country,
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

                    ],
                  ),
                  SizedBox(height: context.getDefaultSize()*1,),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SizedBox(
                        width:context.getDefaultSize()*12 ,
                        child: CustomTextForm(
                          inputFormatters:
                          [
                            LengthLimitingTextInputFormatter(4),
                          ],
                          maxLines: 1,
                          obscureText: false,
                          hinttext:"FloorNo." ,
                          mycontroller:floorNumber,
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
                      SizedBox(width: context.getDefaultSize()*1,),
                      SizedBox(
                        width:context.getDefaultSize()*11,
                        child: CustomTextForm(
                          inputFormatters:
                          [
                            LengthLimitingTextInputFormatter(4),
                          ],
                          maxLines: 1,
                          obscureText: false,
                          hinttext:"FlatNo." ,
                          mycontroller:flatNumber,
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
                    ],
                  ),
                  SizedBox(height: context.getDefaultSize()*1.6,),
                  CustomTextForm(
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
                  SizedBox(height: context.getDefaultSize()*1.6,),
                  CustomTextForm(
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


                  ),
                  SizedBox(height: context.getDefaultSize()*4,),
        BlocBuilder<SignUpBloc, SignUpState>(
          builder: (context, state) {
            return Center(
              child: Container(
                height: 35,
                width: 210,
                child: ElevatedButton(
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all(Colors.black),
                    shape: MaterialStateProperty.all(
                      RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                    ),
                  ),
                  onPressed: state is! SignUpLoading
                      ? () {
                    BlocProvider.of<SignUpBloc>(context).add(
                      SignUpButtonPressed(
                        fullName: fullName.text,
                        email: email.text,
                        password: password.text,
                        phone: phone.text,
                        street: street.text,
                        city: city.text,
                        region: region.text,
                        country: country.text,
                        flatNumber: flatNumber.text,
                        floorNumber: floorNumber.text,
                        latitude: _currentPosition?.latitude ?? 0.0,
                        longitude: _currentPosition?.longitude ?? 0.0,
                      ),
                    );
                  }
                      : null,
                  child: state is SignUpLoading
                      ? CircularProgressIndicator(
                    valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                  )
                      : Text('Sign Up'),
                ),
              ),
            );
          },
        ),
                  SizedBox(height: context.getDefaultSize()*4,),
                  const Row(
                      children: <Widget>[
                        Expanded(
                            child: Divider()
                        ),

                        Text("OR"),

                        Expanded(
                            child: Divider()
                        ),
                      ]
                  ),
                  SizedBox(height: context.getDefaultSize()*1.6,),
                  Center(
                    child: ElevatedButton.icon(
                      style: ButtonStyle(backgroundColor: MaterialStatePropertyAll(Colors.black)),
                      onPressed: ()
                      {
                        signInWithGoogle(context);
                      }, icon:Icon(FontAwesomeIcons.google), label:Text('Continue with Google',style: TextStyle(color: Colors.white),),),
                  ),
                  SizedBox(height: context.getDefaultSize()*4,),
                  Row(
                    mainAxisAlignment:MainAxisAlignment.center,
                    children:
                    [
                      const Text('Are you have account?'),
                      TextButton(onPressed: ()
                       {
                        Navigator.of(context).pop(MaterialPageRoute(builder: (context) =>LoginPage(),
                        )
                        );
                        }, child:Text('Sign in',style: TextStyle(color: Colors.orange))),




                    ],
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

