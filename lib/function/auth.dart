// ignore_for_file: unused_local_variable, avoid_print

import 'dart:developer';
import 'dart:typed_data';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:instagramclone/model/user.dart' as model;
import 'package:instagramclone/utility/storage.dart';
import 'package:shared_preferences/shared_preferences.dart';
// import 'package:flutter/material.dart';

class Auth {
  final _auth = FirebaseAuth.instance;
  User? currentuid = FirebaseAuth.instance.currentUser;
  // get user detail
  // getUserDetail from User model so <model.User> , model is declare as model so model.User where as User is Model
  Future<model.User> getUserDetail() async {
    // DocumentSnapshot snap=FirebaseFirestore.instance.collection('users').doc(currentuid!.uid).get();
    DocumentSnapshot<Map<String, dynamic>> snap = await FirebaseFirestore
        .instance
        .collection('users')
        .doc(currentuid!.uid)
        .get();
    return model.User.fromsnap(snap);
  }

// UPDATE LIKE.......................
  Future<void> updateLike(String uid, String postid, List like) async {
    try {
      if (like.contains(uid)) {
        FirebaseFirestore.instance.collection('posts').doc(postid).update({
          'like': FieldValue.arrayRemove([uid])
        });
        log('ded');
      }
      else{
  FirebaseFirestore.instance.collection('posts').doc(postid).update({
        'like': FieldValue.arrayUnion([uid])
      });
      }
    
        log(uid);
    } catch (e) {
      e.toString();
    }
  }

  // signup
  Future<String> signUpUser({
    // uta signup function bata users data yeta declare garcha
    required String email,
    required String password,
    // required  formkey,
    required String repassword,
    required Uint8List file,
    required String bio,
    required String username,
  }) async {
    String res = 'something went wrong.';
    if (password == repassword) {
      try {
        UserCredential users = await _auth.createUserWithEmailAndPassword(
            email:
                // tye user entered data check
                email,
            password: password);
        final uid = FirebaseAuth.instance.currentUser!.uid;
        //tranfer path and imagee to store in firebsestorage.
        final photoUrl =
            await Storage().uploadImage('profilepics', file, false);

//           //add users to DB..........................................
// uta user model banako attributes haru
// hami le sidai data set garna mildaina tesaile we convert to json format by Map<String,dynamic>toJson()=>{'uid':uid}yesari
        model.User modelusers = model.User(
            username: username,
            uid: uid,
            bio: bio,
            email: email,
            password: password,
            repassword: repassword,
            photoUrl: photoUrl,
            followers: [],
            following: []);
        final authuser = FirebaseFirestore.instance
            .collection('users')
            .doc(uid)
            // sidai agi ko use garna namileko le .toJson haleko Json format hamile model ma banako rta use huncha
            .set(modelusers.toJson());

        res = 'you have successfully login.';
      } on FirebaseAuthException catch (e) {
        if (e.code == 'weak-password') {
          print('The password provided is too weak.');
          res = ("The password provided is too weak.");
        } else if (e.code == 'email-already-in-use') {
          print('The account already exists for that email.');
          res = ("The account already exists for that email.");
        }
      } catch (e) {
        res = e.toString();
      }
    } else {
      res = 'please make sure your password and confirm password is same.';
    }

    return res;
  }

//login validate and store in DB................................................................

  Future<String> loginUser(
      {required String email, required String password}) async {
    String res = "Something went wrong.";
    if (email.isNotEmpty && password.isNotEmpty) {
      try {
        UserCredential userCredential = await FirebaseAuth.instance
            .signInWithEmailAndPassword(email: email, password: password);
        if (userCredential != null) {
          res = "you have sucessfully login.";
          SharedPreferences preferences = await SharedPreferences.getInstance();

          preferences.setString('email', email);
          preferences.setString('password', password);
        }
      } on FirebaseAuthException catch (e) {
        if (e.code == 'user-not-found') {
          print('No user found for that email.');
          res = 'No user found for that email.';
        } else if (e.code == 'wrong-password') {
          print('Wrong password provided for that user.');
          res = "Wrong password provided for that user.";
        }
      } catch (e) {
        res = e.toString();
      }
    } else {
      res = "please fill the input field with validate user.";
    }
    return res;
  }

  // end of login

  //shared preference........................................
  getVisiting() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    bool alreadyVisited = preferences.getBool("alreadyVisited") ?? false;
    return alreadyVisited;
  }

  setVisiting() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();

    preferences.setBool("alreadyVisited", true);
  }
}
