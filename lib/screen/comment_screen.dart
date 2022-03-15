import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:instagramclone/function/auth.dart';
import 'package:instagramclone/function/methods.dart';
import 'package:instagramclone/utility/colors.dart';
import 'package:instagramclone/widget/comment.dart';

class CommentScreen extends StatefulWidget {
  final snap;

  const CommentScreen({Key? key, this.snap}) : super(key: key);

  @override
  _CommentScreenState createState() => _CommentScreenState();
}

class _CommentScreenState extends State<CommentScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: mobileBackgroundColor,
        leading: IconButton(
            onPressed: () => Methods().cancel,
            icon: const Icon(Icons.arrow_back)),
        title: const Text('Comments'),
        //     actions: [
        //  IconButton(onPressed: (){}, icon: Icon(Icons.send))
        //   ]
      ),
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
                flex: 3,
                child: Container(
                  child: Column(
                    children: [
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.symmetric(
                                vertical: 5, horizontal: 10),
                            child: CircleAvatar(
                              radius: 23,
                              backgroundImage:
                                  NetworkImage(widget.snap['photourl']),
                            ),
                          ),
                          Expanded(
                              child: Text(
                            widget.snap['description'],
                            style: TextStyle(
                              fontWeight: FontWeight.w600,
                              fontSize: 20),
                          ))
                        ],
                      ),
                      const Divider(
                        color: secondaryColor,
                      ),
                      // StreamBuilder(
                      //   stream: FirebaseFirestore.instance.collection('posts').doc(postid),
                      //   builder: (BuildContext context, AsyncSnapshot<QuerySnapshot>snapshot)
                      // {

                      // })
                    ],
                  ),
                )),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Comment(
                snap: widget.snap,
              ),
            )
          ],
        ),
      ),
    );
  }
}
