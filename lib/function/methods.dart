import 'package:flutter/cupertino.dart';
import 'package:uuid/uuid.dart';
import 'package:instagramclone/model/comment.dart' as Cmt;
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
class Methods
{
 // cancel
  void cancel(BuildContext context) {
    Navigator.pop(context);
  }
// save comments
 Future<String> storeComment(String uid, String postid, String username,
      String photourl, String comment) async {
    String res = "Something went wrong";
    var commentid = const Uuid().v1(); 
    Cmt.Comment cmt = Cmt.Comment(
      postid: postid,
      uid: uid,
      username: username,
      photourl: photourl,
      comment: comment,
      commentid: commentid,
    );
    try {
      if (comment.isNotEmpty) {
        await FirebaseFirestore.instance
            .collection('posts')
            .doc(postid)
            .collection('comments')
            .doc(commentid)
            .set(cmt.toJson());
      }
      res = "Comment done";
    } catch (e) {
      res = e.toString();
    }
    return res;
  }
}