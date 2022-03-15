

import 'package:flutter/material.dart';
import 'package:instagramclone/utility/colors.dart';
import 'package:instagramclone/widget/popupmenu.dart';

class CardHeader extends StatefulWidget {
  final snap;
  const CardHeader({
    Key? key, required this.snap,
  }) : super(key: key);

  @override
  State<CardHeader> createState() => _CardHeaderState();
}

class _CardHeaderState extends State<CardHeader> {
  @override
  Widget build(BuildContext context) {
    return 
          Container(
            color: mobileBackgroundColor,
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 2, horizontal: 8)
                  .copyWith(right: 0),
              child: Row(
                children: [
                  CircleAvatar(
                      radius: 20,
                      backgroundImage: NetworkImage(widget.snap['photourl'])),
                  Expanded(
                      child: Padding(
                    padding: const EdgeInsets.only(left: 5),
                    child: Text(
                      widget.snap['username'],
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.w700),
                    ),
                  )),
                  PopupMenu(),
                ],
              ),
            ),
          );
  }
}
