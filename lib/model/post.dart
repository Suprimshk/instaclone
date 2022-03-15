

import 'package:cloud_firestore/cloud_firestore.dart';

class Post {
  final String imageurl;
  final like;
  final String description;
  final String postid;
  final String uid;
  final postdate;
  final String username;
  final photourl;

  Post(
      {required this.imageurl,
      required this.like,
      required this.description,
      required this.postid,
      required this.uid,
      required this.username,
      required this.postdate,
        required this.photourl,

      });
      Map<String,dynamic>toJson()=>{
'imageurl':imageurl,
'like':like,
'description':description,
'postid':postid,
'uid':uid,
'username':username,
'postdate':postdate,
'photourl':photourl
      };
      static Post snappost(DocumentSnapshot snap)
       {
         var snapshot=snap.data() as Map<String,dynamic>;
        return  Post(
           imageurl:snapshot['imageurl'],
            like:snapshot['like'],
             description:snapshot['description'],
              postid:snapshot['postid'],
               uid:snapshot['uid'],
                username:snapshot['username'],
                 postdate:snapshot['postdate'],
                   photourl:snapshot['photourl'],
         );
       }
}
