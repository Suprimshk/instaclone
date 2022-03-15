import 'package:cloud_firestore/cloud_firestore.dart';

class User {
  // declare all the field needed for the user input
  final String uid;
  final String username;
  final String bio;
  final String email;
  final String password;
   final String photoUrl;
  final String repassword;
  final dynamic followers;
  final dynamic following;
// constructor
  User(
      {required this.username,
      required this.uid,
      required this.bio,
      required this.email,
      required this.password,
      required this.repassword,
        required this.photoUrl,
      required this.followers,
      required this.following});
  // converting to json
  Map<String, dynamic> toJson() => {
        'uid': uid,
        'username': username,
        'email': email,
        'bio': bio,
        'password': password,
        'repassword': repassword,
        'photoUrl': photoUrl,
        'following': following,
        'followers': followers,
      };
  static User fromsnap(DocumentSnapshot snap) {
    var snapshot = snap.data() as Map<String, dynamic>;
    return User(
      bio: snapshot['bio'],
      username: snapshot['username'],
      password: snapshot['password'],
      uid: snapshot['uid'],
      email: snapshot['email'],
      repassword: snapshot['repassword'],
       photoUrl: snapshot['photoUrl'],
      followers: snapshot['followers'],
      following: snapshot['following'],
    );
  }
}
