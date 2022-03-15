
import 'package:flutter/material.dart';
import 'package:instagramclone/utility/colors.dart';

class Logo extends StatelessWidget {
  const Logo({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Image.asset(
      "assets/images/insta.png",
      color: primaryColor,
      height: 64,
    );
  }
}
