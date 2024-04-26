import 'dart:io';

import 'package:aid_humanity/core/extensions/translation_extension.dart';
import 'package:aid_humanity/core/utils/app_router/app_router.dart';
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../../core/utils/styles/styles.dart';
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
  TextEditingController address = TextEditingController();
  GlobalKey<FormState>formState=GlobalKey();
  bool isloading =true;
  bool isPassword =true;
  CollectionReference categories = FirebaseFirestore.instance.collection('UsersAuth');

  File?select;
  String? url;
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
  String displayName ='';
  String Email ='';
  String photoUrl='';
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
        padding: const EdgeInsets.only(top: 95,left: 20,right: 20),
        child: ListView(
          children:
          [
            // Center(
            //   child: Stack(
            //     clipBehavior: Clip.none, // Clip overflowing widgets
            //     children: [
            //       CircleAvatar(
            //
            //         radius: 50.0,
            //         child: url == null
            //             ? Text('')
            //             : ClipOval(child: Image.network(url!, fit: BoxFit.fill)),
            //       ),
            //       Positioned(
            //         right: context.getDefaultSize() * 0.2, // Adjust positioning as needed
            //         bottom:context.getDefaultSize() * 0, // Adjust positioning as needed
            //         child: Container(
            //           height: context.getDefaultSize() * 3.5,
            //           width: context.getDefaultSize() * 3.5,
            //           decoration: BoxDecoration(
            //             color: kPrimaryColor, // Change color as desired
            //             shape: BoxShape.circle,
            //           ),
            //           child: IconButton(
            //             icon: Icon(
            //               Icons.add,
            //               size: context.getDefaultSize() * 2,
            //               color: Colors.white,
            //             ),
            //             onPressed:()
            //             {
            //               SelectAndUploadImage();
            //
            //
            //             },
            //           ),
            //         ),
            //       ),
            //       // ElevatedButton(onPressed: ()
            //       // {
            //       //   Navigator.of(context).push(MaterialPageRoute(builder: (context)
            //       //   {
            //       //     return ProfilePage(k: url!,);
            //       //   }));
            //       // }, child:Text("nh")
            //       // )
            //     ],
            //   ),
            // ),
            Form(
              key: formState,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children:
                [

                   Padding(
                    padding: EdgeInsets.only(left: 5),
                    child: Text(context.translate('Sign Up'),style: Styles.textStyle25,),
                  ),

                  Padding(
                    padding: EdgeInsets.only(top: 40,),
                    child: CustomTextForm(
                      obscureText: false,


                      hinttext:context.translate("Full Name") ,
                      mycontroller:fullName ,
                      validator: (val)
                      {
                        if(val=="")
                        {
                          return context.translate('can not to be empty');
                        }
                        return null;
                      },

                    ),

                  ),

                  Padding(
                    padding: const EdgeInsets.only(top: 15),
                    child:CustomTextForm(
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
                          return context.translate('can not to be empty');
                        }
                        return null;
                      },

                    ),
//             child: IntlPhoneField(
//               autofocus: true,
//               focusNode:FocusNode(),
//               // searchText:b ,
//               // initialCountryCode: b,
//                initialCountryCode: "IN",
//                 controller:phone ,
// onCountryChanged: (value)
// {
//   print("hhhhhhhhhhhhhhhhhhhhhh""${value.code}");
// },
//  onChanged: (value)
//  {
//
//    print("Countryhghghghghghghghghghghghg""${value.countryCode}");
//  },
//               decoration: InputDecoration(
//
//                 hintText: 'Phone Number',
//                 border: OutlineInputBorder(
//                   borderSide: BorderSide(),
//                 ),
//               ),
//             ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: 15),
                    child: CustomTextForm(
                      maxLines: 4,
                      obscureText: false,
                      hinttext:context.translate("Enter your Address") ,
                      mycontroller:address ,
                      validator: (val)
                      {
                        if(val=="")
                        {
                          return context.translate('can not to be empty');
                        }
                        return null;
                      },

                    ),

                  ),
                  Padding(
                    padding: EdgeInsets.only(top: 15,),
                    child: CustomTextForm(
                      obscureText: false,
                      hinttext:context.translate("Email") ,
                      mycontroller:email ,
                      validator: (val)
                      {
                        if(val=="")
                        {
                          return context.translate('can not to be empty');
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
                        hinttext: context.translate("Password"),
                        mycontroller: password,
                        validator: (val)
                        {
                          if(val=="")
                          {
                            return context.translate('can not to be empty');
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
       final creditional= await FirebaseAuth.instance.createUserWithEmailAndPassword(
          email: email.text,
          password: password.text,
        );

       final d= FirebaseAuth.instance.currentUser!.uid;
        SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
        sharedPreferences.setString("userId", d);
        String? userId = sharedPreferences.getString("userId");
       final  f=categories.doc();
       String?doc;

         // sharedPreferences.setString("categories",categories as String ) ;
      // final c= sharedPreferences.getString("categories");
      //  CollectionReference<Object?> Cat = c as CollectionReference<Object?>;
       DocumentReference add=await categories.add({
         "Full Name":fullName.text,
         "Email":email.text,
         "Phone":phone.text,
         "Address":address.text,
         "id": userId
       });
       doc = add.id;
       print(doc);
       // Save docId in SharedPreferences (optional):
       sharedPreferences.setString("doc", doc);
       // SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
       // sharedPreferences.setString("userId", d);
       // ChoiceItem(g: d,);
       // addUsersData();
      await FirebaseAuth.instance.currentUser!.sendEmailVerification();
       Navigator.of(context).pushNamedAndRemoveUntil(AppRouter.login, (route) => false);
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
            title: context.translate('Error'),
            desc:context.translate( 'Try another email or password'),
            buttonsTextStyle: const TextStyle(color: Colors.black),
            showCloseIcon: true,

          ).show();
          print(context.translate('The account already exists for that email.'));
        }
      } catch (e) {
        print(e);
      }
    }
                          }, child:Text
                        (context.translate('Sign Up'))),
                    ),
                  ),
                  SizedBox(height: 35,),
                  Row(
                      children: <Widget>[
                        Expanded(
                            child: Divider()
                        ),

                        Text(context.translate("OR")),

                        Expanded(
                            child: Divider()
                        ),
                      ]
                  ),
                  const SizedBox(height: 15,),
                  Center(
                    child: ElevatedButton.icon(
                      style: ButtonStyle(backgroundColor: MaterialStatePropertyAll(Colors.black)),
                      onPressed: ()
                      {
                        signInWithGoogle(context);
                      }, icon:Icon(FontAwesomeIcons.google), label:Text(context.translate('Continue with Google'),style: TextStyle(color: Colors.white),),),
                  ),
                  const SizedBox(height: 18,),
                  Row(
                    mainAxisAlignment:MainAxisAlignment.center,
                    children:
                    [
                     Text(context.translate('Are you have account?')),
                      TextButton(onPressed: ()
                       {

                        //pushReplacementNamed --> علشان ميعملش back button
                        Navigator.of(context).push(MaterialPageRoute(builder: (context) =>LoginPage(),
                        )
                        );
                        }, child:Text(context.translate('Sign in'),style: TextStyle(color: Colors.orange))),




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

