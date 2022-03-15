import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:instagramclone/provider/user_provider.dart';
import 'package:instagramclone/utility/colors.dart';
import 'package:instagramclone/widget/feed.dart';
import 'package:instagramclone/widget/logo.dart';
import 'package:provider/provider.dart';

class NewsFeed extends StatefulWidget {
  const NewsFeed({Key? key}) : super(key: key);

  @override
  _NewsFeedState createState() => _NewsFeedState();
}

class _NewsFeedState extends State<NewsFeed> {
  final uid = FirebaseAuth.instance.currentUser!.uid;
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: mobileBackgroundColor,
          title: Padding(
            padding: const EdgeInsets.only(left: 5, bottom: 0),
            child: Image.asset(
              "assets/images/insta.png",
              color: primaryColor,
              height: 40,
            ),
          ),
          actions: [
            Padding(
              padding: const EdgeInsets.only(right: 5),
              child: Row(
                children: [
                  IconButton(
                      onPressed: () => notification(),
                      icon: const FaIcon(FontAwesomeIcons.heart, size: 25)),
                  const SizedBox(
                    width: 3,
                  ),
                  IconButton(
                      onPressed: () => notification(),
                      icon: const FaIcon(FontAwesomeIcons.facebookMessenger,
                          size: 25)),
                ],
              ),
            )
          ],
          centerTitle: false,
        ),
        body: StreamBuilder(
          stream: FirebaseFirestore.instance
          .collection('posts')
          .snapshots(),
          builder:
          (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (snapshot.hasError) {
          log("nodata");
          return const Text("Something went wrong");
        }

        if (!snapshot.hasData) {
           log("nodata");
          return const Text("Document does not exist");
         
        }

        if (snapshot.connectionState == ConnectionState.waiting) {
          log("wait");
          return const Center(
              child: CircularProgressIndicator(color: primaryColor));
        }
        log("cha data");
        return ListView.builder(
          shrinkWrap: true,
          itemCount: snapshot.data!.docs.length,
          itemBuilder: (context, index) {
            return FeedCard(
               snap:snapshot.data!.docs[index].data(),
            );
          },
        );
          },
        ),
      ),
    );
  }

  notification() {}
}
