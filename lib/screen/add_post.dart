// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'dart:developer';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:image_picker/image_picker.dart';
import 'package:instagramclone/function/methods.dart';
import 'package:instagramclone/function/upload.dart';
import 'package:instagramclone/model/user.dart';
import 'package:instagramclone/provider/user_provider.dart';
import 'package:instagramclone/screen/profile.dart';
import 'package:instagramclone/utility/colors.dart';
import 'package:instagramclone/utility/utils.dart';

import 'package:provider/provider.dart';

class AddPost extends StatefulWidget {
  const AddPost({Key? key}) : super(key: key);

  @override
  _AddPostState createState() => _AddPostState();
}

class _AddPostState extends State<AddPost> {
  Uint8List? _file;
bool _isloading=false;
  final TextEditingController _descriptionController = TextEditingController();

  // open after selecting in dialog box to choose image from gallery
  void _selectPost() async {
    Navigator.pop(context);
    Uint8List file = await pickImages(ImageSource.gallery);
    setState(() {
      _file = file;
    });
  }

  // opens camera
  void selectCamera() async {
    Navigator.of(context).pop();
    Uint8List file = await pickImages(ImageSource.camera);
    setState(() {
      _file = file;
    });
  }


  // opens dialog box
  _selectImage(BuildContext context) async {
    return showDialog(
        context: context,
        builder: (context) {
          return SimpleDialog(
            children: [
              // open Gallery
              SimpleDialogOption(
                onPressed: _selectPost,
                child: Text("Select from Gallery."),
              ),

              // open camera
              SimpleDialogOption(
                onPressed: selectCamera,
                child: Text("select from Camera."),
              ),

              //  cancel
              SimpleDialogOption(onPressed: ()=>Methods().cancel, child: Text("Cancel")),
            ],
          );
        });
  }

  // post
  void postpost(String uid, String username, String photoUrl) async{
    setState(() {
      _isloading=true;
    });
    // passing as a argument to store in a DB
    try {
      String res= await Upload().postImage(
      description: _descriptionController.text,
      uid: uid,
      username: username,
      photourl:photoUrl,
      file: _file!,);
      
    //   Navigator.of(context).push(MaterialPageRoute<void>(
    //   builder: (BuildContext context) => const Profile(),
    // ),);
    if(res == 'done')
    {
     await showSnackbar("Posted", context);
   
          await back();
          // Navigator.of(context).pushAndRemoveUntil(
          //          (MaterialPageRoute(builder: 
          //         ((context) => Profile() )))
          //          , (route) => false);
    }
    else{
      showSnackbar(res, context);
    }
  
    } catch (e) {
      showSnackbar(e.toString(), context);
    }
   setState(() {
     _isloading=false;
   });
  }
  // back
  back(){
setState(() {
  _file=null;
});
  }
  @override
  void dispose() {
    _descriptionController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    
    final User _user = Provider.of<UserProvider>(context).getUser;
    log(_user.bio);
    return _file == null
        ? Center(
            child: IconButton(
                onPressed: () => _selectImage(context),
                icon: Icon(
                  Icons.upload,
                  size: 40,
                )),
          )
        : SafeArea(
            child: Scaffold(
              appBar: AppBar(
                  leading: Center(
                      child: IconButton(
                    icon: FaIcon(FontAwesomeIcons.times),
                    onPressed: (() => 
                    back()
                    // Navigator.of(context).push(
                    //       MaterialPageRoute(
                    //         builder: (BuildContext context) => const Profile(),
                    //       ),
                    //     )
                        ),
                  )),
                  title: Text("New Post"),
                  centerTitle: false,
                  actions: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                            margin: EdgeInsets.only(right: 20),
                            child: IconButton(
                              onPressed: ()=>postpost(
                                  _user.uid, _user.username, _user.photoUrl),
                              icon: Icon(Icons.arrow_forward),
                              color: blueColor,
                            ))
                      ],
                    )
                  ]),
              body: Container(
                padding: EdgeInsets.all(20.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    _isloading?
                    Container(padding: EdgeInsets.symmetric(vertical: 5.0),
                      child: LinearProgressIndicator(color: blueColor),)
                   :
                   Container(), Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 20),
                          child: CircleAvatar(
                            radius: 25.0,
                            // dp
                            backgroundImage: NetworkImage(_user.photoUrl),
                          ),
                        ),
                        Expanded(
                          flex: 1,
                          child: Container(
                            padding: EdgeInsets.symmetric(horizontal: 20.0),
                            width: MediaQuery.of(context).size.width * 0.1,
                            child: TextFormField(
                                maxLines: 4,
                                decoration: InputDecoration(
                                    hintText: "Write a Caption....",
                                    border: InputBorder.none),
                                controller: _descriptionController,
                                onChanged: (value) {
                                  setState(() {
                                    value = _descriptionController.text;
                                  });
                                },
                                keyboardType: TextInputType.text),
                          ),
                        ),
                        SizedBox(
                            height: 55,
                            width: 65,
                            child:
                                //  to use aspect ratio is to manage width and height of child
                                AspectRatio(
                                    aspectRatio: 487 / 451,
                                    child: Container(
                                      decoration: BoxDecoration(
                                          shape: BoxShape.rectangle,
                                          image: DecorationImage(
                                              image: MemoryImage(_file!))),
                                    ))),
                      ],
                    )
                  ],
                ),
              ),
            ),
          );
  }
}
