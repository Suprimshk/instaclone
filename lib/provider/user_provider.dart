import 'package:flutter/cupertino.dart';
import 'package:instagramclone/function/auth.dart';
import 'package:instagramclone/model/user.dart';

class UserProvider with ChangeNotifier{
// making _user private is very imp becoz it can be easily accessable if  there withh be other function called sooo private
User? _user;
// to get the _user ,making it public
User get getUser=>_user!;
// ny this we can update the value of user and if its future funtion then async is necessary bcoz we use await in it
Future<void> refreshUser()async {
  User user=await Auth().getUserDetail();
  _user=user;
  // helps to update the value
 notifyListeners();

}
}