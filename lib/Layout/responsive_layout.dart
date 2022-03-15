import 'package:flutter/material.dart';
import 'package:instagramclone/provider/user_provider.dart';
import 'package:instagramclone/responsive/dimension.dart';
import 'package:provider/provider.dart';

class ResponsiveLayout extends StatefulWidget {
  final Widget webScreenLayout;
  final Widget mobScreenLayout;
  const ResponsiveLayout({required this.mobScreenLayout,required this.webScreenLayout, Key? key }) : super(key: key);

  @override
  State<ResponsiveLayout> createState() => _ResponsiveLayoutState();
}

class _ResponsiveLayoutState extends State<ResponsiveLayout> {
  @override
  void initState() {
    super.initState();
    getData();
  }
  // calling refreshUser to notify all change
  // done in this becuse this is the root of layout so..
  void getData()async {
    UserProvider _userprovider=Provider.of(context,listen:false);
   await  _userprovider.refreshUser();
    
  }
  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints){
        if(constraints.maxWidth>webscreen)
        {
          // webscreen
          return widget.webScreenLayout;
        }
        else{
          // mobscreen
          return widget.mobScreenLayout;
        }
      },
      
    );
  }

}