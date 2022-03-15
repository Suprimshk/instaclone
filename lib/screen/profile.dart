import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:instagramclone/model/user.dart'as model;
import 'package:instagramclone/provider/user_provider.dart';
import 'package:instagramclone/screen/add_post.dart';
import 'package:instagramclone/utility/colors.dart';
import 'package:provider/provider.dart';

class Profile extends StatefulWidget {
  const Profile({ Key? key }) : super(key: key);

  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  @override
  Widget build(BuildContext context) {
    final model.User _user=Provider.of<UserProvider>(context).getUser;
    return Scaffold(
      appBar: AppBar(
                  leading: Center(
                      child: IconButton(
                    icon: FaIcon(FontAwesomeIcons.times),
                    onPressed: (() => Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (BuildContext context) => const AddPost(),
                          ),
                        )),
                  )),
                  title: Text("New Post"),
                  centerTitle: false,
                  actions: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                            margin: EdgeInsets.only(right: 20),
                            child: IconButton(
                              onPressed: ()=>signout(),
                              icon: Icon(Icons.arrow_forward),
                              color: blueColor,
                            ))
                      ],
                    )
                  ]),
      body: Center(child: Text(_user.email)));
  }

  signout() async{
    await FirebaseAuth.instance.signOut();
  }
}