// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, avoid_unnecessary_containers

import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:instagramclone/function/auth.dart';
import 'package:instagramclone/provider/user_provider.dart';
import 'package:instagramclone/utility/colors.dart';
import 'package:instagramclone/widget/card_footer.dart';
import 'package:instagramclone/widget/card_header.dart';
import 'package:instagramclone/widget/cardimage.dart';
import 'package:instagramclone/widget/comment.dart';
import 'package:instagramclone/widget/like_animation.dart';
import 'package:instagramclone/widget/popupmenu.dart';
import 'package:provider/provider.dart';

import '../model/user.dart';

class FeedCard extends StatefulWidget {
  final snap;
  const FeedCard({
    Key? key,
    required this.snap,
  }) : super(
          key: key,
        );

  @override
  State<FeedCard> createState() => _FeedCardState();
}

class _FeedCardState extends State<FeedCard> {
  // for not to show the like animation(basically love react)
  bool isLikeAnimating = false;
TextEditingController _commentController=TextEditingController();
  @override
  Widget build(BuildContext context) {
    final User getUser = Provider.of<UserProvider>(context).getUser;
    // feedheader

    return Container(
        child: Padding(
      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 2),
      child: Column(
        children: [
     CardHeader(snap: widget.snap),
// end of feedheader
// feed image
          CardImage(snap: widget.snap),
          // end of feed image
          // feed fotter
         CardFooter(snap: widget.snap),
          // end of feed fotter............................................
        ],
      ),
    ));
  }
}
