import 'dart:typed_data';

import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/material.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:uuid/uuid.dart';
final uid =FirebaseAuth.instance.currentUser!.uid;
class Storage
{
 final FirebaseStorage _storage=FirebaseStorage.instance;
 //addimg to firebase storage 
 Future<String>uploadImage(String childName,Uint8List file,bool isPost)async
 {
   var postid=const Uuid().v1();
   //to define the path profile/userid/image
  Reference ref= _storage.ref().child(childName).child(uid);
  // if it is post we should add one more child  because user can post many post in insta soo it should save with an unique postid  soo we use Uuid to get id and .v1 as per the currentDateTime
  if(isPost==true)
  {
    // to add the child repr for postid
    ref=ref.child(postid);
  }
  //save image in that particular path
  UploadTask upload =ref.putData(file);
//get url for that image so that we can display ,we use await because uploadtast  returns Future value
//snap.ref chai snap bhaneko upload garisakeko file ,ref chai image uploaded
TaskSnapshot snap=await upload;
final downloadurl=snap.ref.getDownloadURL();
return downloadurl;
 }
}