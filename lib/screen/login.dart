// ignore_for_file: prefer_const_constructors, unnecessary_null_comparison, unused_element

import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:instagramclone/Layout/responsive_layout.dart';
import 'package:instagramclone/function/auth.dart';
import 'package:instagramclone/responsive/web_screen_layout.dart';

import 'package:instagramclone/utility/colors.dart';
import 'package:instagramclone/utility/utils.dart';
import 'package:instagramclone/widget/button.dart';
import 'package:instagramclone/widget/logo.dart';
import 'package:instagramclone/widget/text_field_input.dart';

import '../responsive/mob_screen_layout.dart';

class Login extends StatefulWidget {
  const Login({Key? key}) : super(key: key);

  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
   bool _isloading = false;
       final TextEditingController _email = TextEditingController();
    final TextEditingController _password = TextEditingController();
    final _formkey = GlobalKey<FormState>();
    @override
    void dispose() {
      super.dispose();
      _email.dispose();
      _password.dispose();
    }
  @override
  Widget build(BuildContext context) {

   

    login() async {
     
         setState(() {
         _isloading=true;
       });
     
      final res = await Auth().loginUser(
        email: _email.text,
        password: _password.text,
      );
      if (res != null) {
        showSnackbar(res, context);
      }
      if (res == 'you have sucessfully login.') {
       
        await Navigator.of(context).pushReplacement((MaterialPageRoute(
            builder: ((context) => ResponsiveLayout(
                mobScreenLayout: MobScreenLayout(),
                webScreenLayout: WebScreenLayout())))));

        await showSnackbar(res, context);
      }
      // }
      setState(() {
        _isloading = false;
      });
    }

    return Scaffold(
      body: SafeArea(
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 0.0, vertical: 0.0),
          width: double.infinity,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              //  SizedBox(height: 50.0,),
              //top flex gap.........................................................................................
              Flexible(
                child: Container(),
                flex: 2,
              ),
              //images.........................................................................................
              Logo(),
              Expanded(flex: 1, child: SizedBox()),
              //Email input..........................................................................................
              Expanded(
                flex: 1,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 32.0),
                  child: TextFieldInput(
                      validator: (value) {
                        if (value!.isEmpty) {
                          return ("Email Field cant be empty");
                        }
                      },
                      onChange: (value) {
                        setState(() {
                          value = _email;
                        });
                      },
                      textController: _email,
                      textHint: "Please Enter Your Email",
                      textInputType: TextInputType.emailAddress),
                ),
              ),
              //Password input..........................................................................................
              Expanded(
                flex: 1,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 32.0),
                  child: TextFieldInput(
                    validator: (value) {
                      if (value.isEmpty) {
                        return Text(
                          "Password Field cant be empty",
                          style: TextStyle(color: Colors.red),
                        );
                      }
                    },
                    onChange: (value) {
                      setState(() {
                        value = _password;
                      });
                    },
                    textController: _password,
                    textHint: "Please Enter Your Password",
                    textInputType: TextInputType.text,
                    isPass: true,
                  ),
                ),
              ),
              //loginbutton...........................................................................................
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
                    onTap: () => login(),
                    child: Center(
                      child: _isloading
                          ? Center(
                              child: CircularProgressIndicator(
                                color: primaryColor,
                              ),
                            )
                          : Text(
                              "Login",
                              style: TextStyle(
                                  color: primaryColor,
                                  fontSize: 20,
                                  fontWeight: FontWeight.w500),
                            ),
                    ),
                  ),
                ),
              ),
              Flexible(
                child: Container(),
                flex: 1,
              ),
              Divider(
                thickness: 1,
                color: primaryColor,
              ),
//dont have anount ?.............................................................
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Don't have an account?",
                    style: TextStyle(color: primaryColor),
                  ),
                  SizedBox(
                    width: 0,
                  ),
                  //signupbutton.............................................................................................
                  TextButton(
                      onPressed: () {
                        Navigator.pushNamed(context, "/signup");
                      },
                      child: Text("Sign up.",
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
    );
  }

  // gotoHome() async{
  // await Navigator.pushNamed(context, "/signup");

  // }
}
