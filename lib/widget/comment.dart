
import 'package:flutter/material.dart';
import 'package:instagramclone/function/methods.dart';
import 'package:instagramclone/provider/user_provider.dart';
import 'package:provider/provider.dart';
import 'package:uuid/uuid.dart';
import 'package:instagramclone/model/comment.dart' as Cmt;

class Comment extends StatefulWidget {
  final snap;
  const Comment({Key? key, this.snap}) : super(key: key);

  @override
  _CommentState createState() => _CommentState();
}

class _CommentState extends State<Comment> {
  final TextEditingController _commentController = TextEditingController();
  @override
  void dispose() {
    _commentController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final getUser = Provider.of<UserProvider>(context).getUser;
    return Container(
      child: Row(children: [
        CircleAvatar(
          radius: 12,
          backgroundImage: NetworkImage(getUser.photoUrl),
        ),
        Expanded(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: TextFormField(
              maxLines: 1,
              controller: _commentController,
              onChanged: (value) {
                setState(() {
                  value = _commentController.text;
                });
              },
              decoration: InputDecoration(
                  border: InputBorder.none, hintText: "Add a Comment..."),
            ),
          ),
        ),
        IconButton(
          onPressed: () async {await Methods().storeComment(getUser.uid, widget.snap['postid'],
              getUser.username, getUser.photoUrl, _commentController.text);},
          icon: Icon(Icons.send),
          iconSize: 15,
        )
      ]),
    );
  }

 
}
