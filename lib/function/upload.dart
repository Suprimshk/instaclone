import 'dart:typed_data';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:instagramclone/model/post.dart';
import 'package:instagramclone/utility/storage.dart';
import 'package:uuid/uuid.dart';

class Upload {
  final uid = FirebaseAuth.instance.currentUser!.uid;
  Future<String> postImage({
    required String uid,
    required String username,
     required String photourl,
    required Uint8List file,
    required String description,
  
  }) async {
   
    String res = "something went Wrong";
    try {
      final postUrl = await Storage().uploadImage('post', file, true);
      var postid = const Uuid().v1();
      // model data
      Post post = Post(
        imageurl: postUrl,
        description: description,
        postid: postid,
        uid: uid,
        username: username,
        postdate: DateTime.now(),
        photourl: photourl,
        like: [],
      );
      // to store in DB
      FirebaseFirestore.instance
          .collection('posts')
          
          .doc(postid)
          .set(post.toJson());
      res = "done";
    } catch (e) {
      res = e.toString();
    }
    return res;
  }
}
