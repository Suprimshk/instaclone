class Comment {
  final String postid;
  final String uid;
  final String username;
  final String photourl;
  final String comment;
  final String commentid;

  Comment(
      {required this.postid,
      required this.uid,
      required this.username,
      required this.photourl,
      required this.comment,
      required this.commentid});
      Map<String,dynamic>toJson()=>{
'postid':postid,
'uid':uid,
'username':username,
'photourl':photourl,
'comment':comment,
'commentid':commentid,
      };
}
