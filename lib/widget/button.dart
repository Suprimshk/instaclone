// ignore_for_file: prefer_const_constructors



import 'package:flutter/material.dart';
import 'package:instagramclone/utility/colors.dart';

class Button extends StatelessWidget {
  const Button({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: EdgeInsets.all(5.0),
        decoration: ShapeDecoration(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(
              Radius.circular(4),
            ),
          ),
        ),
        color:blueColor,
        child: InkWell(
          //  onTap:onTap ,
          borderRadius: BorderRadius.circular(10),
          child: Center(
              heightFactor: 2,
              widthFactor: 10,
              child: Text(
                "Login",
                style: TextStyle(
                    color: mobileBackgroundColor,
                    fontSize: 20,
                    fontWeight: FontWeight.w500),
              )),
        ),
      ),
    );
  }
}
