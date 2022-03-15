// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:instagramclone/model/user.dart' as model;
import 'package:instagramclone/provider/user_provider.dart';
import 'package:instagramclone/screen/add_post.dart';
import 'package:instagramclone/screen/login.dart';
import 'package:instagramclone/screen/news_feed.dart';
import 'package:instagramclone/screen/profile.dart';
import 'package:instagramclone/utility/colors.dart';
import 'package:provider/provider.dart';

class MobScreenLayout extends StatefulWidget {
  const MobScreenLayout({Key? key}) : super(key: key);

  @override
  State<MobScreenLayout> createState() => _MobScreenLayoutState();
}

class _MobScreenLayoutState extends State<MobScreenLayout> {
  // at which screen to view with the help of  _curerntIndex
     int _currentIndex = 0;
    //  pagecontroller helps to control the page as per the bottom nav bar
   PageController _pageController=PageController();
  //  to navigate as per the tab
    void navigationTab(int page) {
    _pageController.jumpToPage(page);
    }
    // as to see  after the page reload
    @override
    void initState() {
      super.initState();
      _pageController=PageController();
    }
    @override
    void dispose() {
      _pageController.dispose();
      super.dispose();
    }
  @override
  Widget build(BuildContext context) {

    // declare provider
    // model.User userr=Provider.of<UserProvider>(context).getUser;
    return Scaffold(
      // view the particular tab as per the controller
        body:PageView(
          // not to switch screen just by sliding just switching by taping
          physics: NeverScrollableScrollPhysics(),
           onPageChanged: onPageChanged,
          controller: _pageController,
          children: [
            // view serially as per tab
NewsFeed(),
Center(child: Text("search"),),
AddPost(),
Profile(),
        ],),
        bottomNavigationBar: BottomNavigationBar(
         onTap:navigationTab,
          items: [
            // particular tab i.e=home(feed)
            BottomNavigationBarItem(
              icon: FaIcon(FontAwesomeIcons.home,color: _currentIndex==0 ? primaryColor: secondaryColor,),
              label: "",
              backgroundColor: mobileBackgroundColor,
              ),
              // particular tab i.e=search
               BottomNavigationBarItem(
              icon: FaIcon(FontAwesomeIcons.search,color: _currentIndex==1 ? primaryColor: secondaryColor,),
              label: "",
              backgroundColor: mobileBackgroundColor,
              ),
                   // particular tab i.e=add post
               BottomNavigationBarItem(
              icon: Icon(Icons.add_box_outlined,color: _currentIndex==2 ? primaryColor: secondaryColor,),
              label: "",
              backgroundColor: mobileBackgroundColor,
              ),
                   // particular tab i.e=profile
               BottomNavigationBarItem(
              icon: FaIcon(FontAwesomeIcons.user,color: _currentIndex==3 ? primaryColor: secondaryColor,),
              label: "",
              backgroundColor: mobileBackgroundColor,
              ),
          ],
        )
        //  using provider
        // Text(userr.username
        //  ,style:const TextStyle(color:blueColor)
        //  ),
        
        );
  }
// chamge the index and view as per the  change in tab
  void onPageChanged(int value) {
    setState(() {
       _currentIndex=value;
    });
  //  log(_currentIndex.toString());
  }
}
