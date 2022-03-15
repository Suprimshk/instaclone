
// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:instagramclone/screen/login.dart';
import 'package:instagramclone/screen/signup.dart';
import 'package:instagramclone/utility/colors.dart';



class PopupMenu extends StatelessWidget {
  
onSelected(BuildContext context, Object? item) {
  switch (item) {
    case 0:
      logout(context);
      // Navigator.of(context).push(
      //   MaterialPageRoute(builder: (context) => Login()),
      // );

      break;
    case 1:
      // Navigator.pushNamed(context, "/setting");

      break;
    default:
  }
}
  const PopupMenu({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
     color: mobileBackgroundColor,
     
      child: PopupMenuButton(
          onSelected: (item) async => onSelected(context, item),
          itemBuilder: (context) => [
             
                 PopupMenuItem(
                  value: 1,
                  child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Icon(Icons.settings,
                            color: Colors.black, size: 18.0),
                        Text("Setting")
                      ]),
                ),
                //  item2
                  
                PopupMenuItem(
                  value: 0,
                  child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Icon(FontAwesomeIcons.signOutAlt,
                            color: Colors.black, size: 18.0),
                        Text("Signout")
                      ]),
                ),
                 // end of PopupItem
              ]),
    );
  }
}


logout(BuildContext context) async {
  await FirebaseAuth.instance.signOut();
  Navigator.pushAndRemoveUntil(context,  MaterialPageRoute<void>(builder: 
  (BuildContext context) => const Login()), (route) => false);
}