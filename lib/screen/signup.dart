// ignore_for_file: prefer_const_constructors

import 'dart:typed_data';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:instagramclone/Layout/responsive_layout.dart';
import 'package:instagramclone/function/auth.dart';
import 'package:instagramclone/responsive/mob_screen_layout.dart';
import 'package:instagramclone/responsive/web_screen_layout.dart';
import 'package:instagramclone/utility/colors.dart';
import 'package:instagramclone/utility/storage.dart';
import 'package:instagramclone/utility/utils.dart';
import 'package:instagramclone/widget/button.dart';
import 'package:instagramclone/widget/logo.dart';
import 'package:instagramclone/widget/text_field_input.dart';

class Signup extends StatefulWidget {
  const Signup({Key? key}) : super(key: key);

  @override
  _SignupState createState() => _SignupState();
}

class _SignupState extends State<Signup> {
  final TextEditingController _email = TextEditingController();
  final TextEditingController _password = TextEditingController();
  final TextEditingController _bio = TextEditingController();
  final TextEditingController _repassword = TextEditingController();
  final TextEditingController _username = TextEditingController();
  bool _loading=false;
  final _formkey = GlobalKey<FormState>();
  Uint8List? _uploadimage;

  @override
  void dispose() {
    super.dispose();
    _email.dispose();
    _password.dispose();
    _username.dispose();
    _bio.dispose();
    _repassword.dispose();
   
   
  }

  void selectImage() async {
    Uint8List imagepicked = await pickImages(ImageSource.gallery);
    setState(() {
      _uploadimage = imagepicked;
    });
  }

void signup() async{
   setState(() {
             _loading=true;
           });
         if (_formkey.currentState!.validate()) {
        //  1.kk store garnu parcha tyo as argument liyera uta signupUser function ma use garincha
            final  String res= await Auth().signUpUser(
        email: _email.text,
        password: _password.text,
        repassword: _repassword.text,
        bio: _bio.text,
           file: _uploadimage!,
        username: _username.text
        // ,formkey: _formkey
        )
        ;
        if(res!=null)
        {
           await showSnackbar(res, context);
        }
       if(res=='you have successfully login.')
       { 
         await showSnackbar(res, context);
          await Navigator.of(context).pushAndRemoveUntil(
                   (MaterialPageRoute(builder: 
                  ((context) =>  ResponsiveLayout(
            mobScreenLayout: MobScreenLayout(),
            webScreenLayout: WebScreenLayout()) )))
                   , (route) => false);
        
        
       }
         }
           setState(() {
             _loading=false;
           });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 0.0, vertical: 0.0),
          width: double.infinity,
          child: Form(
            key: _formkey,
            child: Column(
              children: [
                Flexible(flex: 1, child: Container()),
                // logo
                Logo(),
                Flexible(flex: 1, child: Container()),
                // add DP
                Stack(
                  children: [
                     _uploadimage != null
                         ?
                         CircleAvatar(
                            radius: 65.0,
                            backgroundImage: MemoryImage(_uploadimage!))
                         : 
                         CircleAvatar(
                             radius: 65.0,
                             backgroundImage: NetworkImage(
                                "https://www.nicepng.com/png/detail/202-2024580_png-file-profile-icon-vector-png.png"),
                          ),
                    Positioned(
                        bottom: 6,
                        right: -15,
                        child: IconButton(
                          onPressed: () => selectImage(),
                          icon: Icon(Icons.add_a_photo),
                          iconSize: 30,
                        ))
                  ],
                ),
                SizedBox(height: 30),
                // emialInputfield.................................
                Expanded(
                    child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 23.0),
                  child: TextFieldInput(
                      onChange: (value) {
                        setState(() {
                          value = _email;
                        });
                      },
                      validator: (value) {
                        if (value!.isEmpty) {
                          return ("Email Field cant be empty");
                        }
                      },
                      textController: _email,
                      textHint: "Please enter your email",
                      textInputType: TextInputType.emailAddress),
                )),
                // usernameinputfield............................................
                Expanded(
                    child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 23.0),
                  child: TextFieldInput(
                      validator: (value) {
                        if (value!.isEmpty) {
                          return ("Username Field cant be empty");
                        }
                      },
                      onChange: (value) {
                        setState(() {
                          value = _username;
                        });
                      },
                      textController: _username,
                      textHint: "Please enter your username",
                      textInputType: TextInputType.text),
                )),
                // bio...................................................................
                Expanded(
                    child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 23.0),
                  child: TextFieldInput(
                      validator: (value) {
                        if (value!.isEmpty) {
                          return ("Bio Field cant be empty");
                        }
                      },
                      onChange: (value) {
                        setState(() {
                          value = _bio;
                        });
                      },
                      textController: _bio,
                      textHint: "Please enter your bio",
                      textInputType: TextInputType.text),
                )),
                // password........................................
                Expanded(
                    child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 23.0),
                  child: TextFieldInput(
                      validator: (value) {
                        if (value!.isEmpty) {
                          return ("Password Field cant be empty");
                        }
                      },
                      onChange: (value) {
                        setState(() {
                          value = _password;
                        });
                      },
                      textController: _password,
                      textHint: "Please enter your password",
                      isPass: true,
                      textInputType: TextInputType.visiblePassword),
                )),
                // confirmpassword........................................
                Expanded(
                    child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 23.0),
                  child: TextFieldInput(
                      validator: (value) {
                        if (value!.isEmpty) {
                          return (" Field cant be empty");
                        }
                        if (_password != _repassword) {
                          return ("Password and Confirm Password should matched.");
                        }
                      },
                      onChange: (value) {
                        setState(() {
                          value = _repassword;
                        });
                      },
                      textController: _repassword,
                      textHint: "Please confirm your password",
                      isPass: true,
                      textInputType: TextInputType.visiblePassword),
                )),

                //signupbutton...........................................................................................
                Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 32.0,
                  ),
                  child: Container(
                    width: double.infinity,
                    height: 52,
                    padding: EdgeInsets.all(8.0),
                    decoration: ShapeDecoration(
                      color: blueColor,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(
                          Radius.circular(10.0),
                        ),
                      ),
                    ),
                    child: InkWell(
                      onTap: ()=> signup(),
                      child: Center(
                        child: _loading?Center(child: CircularProgressIndicator(color: primaryColor,)):Text(
                          "Signup",
                          style: TextStyle(
                              color: primaryColor,
                              fontSize: 20,
                              fontWeight: FontWeight.w500),
                        ),
                      ),
                    ),
                  ),
                ),
                Flexible(flex: 1, child: Container()),
                Divider(
                  thickness: 1,
                  color: primaryColor,
                ),
                //dont have anount ?.............................................................
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Already have an account?",
                      style: TextStyle(color: primaryColor),
                    ),
                    SizedBox(
                      width: 0,
                    ),
                    //signupbutton.............................................................................................
                    TextButton(
                        onPressed: () {
                          Navigator.pushNamed(context, "/login");
                        },
                        child: Text("Login.",
                            style: TextStyle(
                                color: primaryColor,
                                fontWeight: FontWeight.w500,
                                fontSize: 17.0)))
                  ],
                ),
                SizedBox(
                  height: 4.0,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  // gotoHome()async {
  //   await Navigator.pushNamed(context, "/home");
  // }
}
