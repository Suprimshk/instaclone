// ignore_for_file: avoid_unnecessary_containers, prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Home extends StatefulWidget {
  const Home({ Key? key }) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  var email='';
    Future<String> getEmail() async{

     SharedPreferences preferences=await SharedPreferences.getInstance();
  setState(() {
    email= preferences.getString('email')!;
  });
return email.toString();
 
  }
    @override
    void initState() {
      super.initState();
      getEmail();
    }
  @override
  Widget build(BuildContext context) {
    
  
    return Scaffold(
      body:Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Center(child: const Text("Home page.",style:TextStyle(color:Colors.white),)),
           Row(
             mainAxisAlignment: MainAxisAlignment.center,
             children: [
                Center(child:  Text("email:",style:TextStyle(color:Colors.white),)),
               Center(child:  Text(email,style:TextStyle(color:Colors.white),)),
             ],
           ),
        ],
      ),
    );
  }


}