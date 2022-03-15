
import 'package:flutter/material.dart';
import 'package:instagramclone/function/auth.dart';
import 'package:instagramclone/provider/user_provider.dart';
import 'package:instagramclone/widget/like_animation.dart';
import 'package:provider/provider.dart';

import '../model/user.dart';

class CardImage extends StatefulWidget {
  final snap;
  const CardImage({
    Key? key, required this.snap,
  }) : super(key: key);

  @override
  State<CardImage> createState() => _CardImageState();
}

class _CardImageState extends State<CardImage> {
  bool isLikeAnimating=false;
  @override
  Widget build(BuildContext context) {
      final User getUser = Provider.of<UserProvider>(context).getUser;
    return GestureDetector(
            // after we double TAp then to show love react
            onDoubleTap: () async {
              await Auth().updateLike(
                  getUser.uid, widget.snap['postid'], widget.snap['like']);
                  // when you like then only activate LikeAnimation and when remove like no any reaction
              if (!widget.snap['like'].contains(getUser.uid)) {
                setState(() {
                  isLikeAnimating = true;
                  // log('showinglove');
                });
              }
            },
            child: Stack(
              children: [
                SizedBox(
                    height: MediaQuery.of(context).size.height * 0.35,
                    width: double.infinity,
                    child: Image(image: NetworkImage(widget.snap['imageurl']))),
                // love react after double tap
                AnimatedOpacity(
                  duration: Duration(milliseconds: 400),
                  opacity: isLikeAnimating ? 1 : 0,
                  child: LikeAnimation(
                    child: Padding(
                      padding: const EdgeInsets.only(top: 60.0),
                      child: Align(
                          alignment: Alignment.center,
                          child: Icon(
                            Icons.favorite,
                            size: 110,
                          )),
                    ),
                    smallLike: false,
                    isAnimating: isLikeAnimating,
                    isEnd: () {
                      setState(() {
                        isLikeAnimating = false;
                      });
                    },
                    // to show the react love for 4 second
                    duration: Duration(milliseconds: 400),
                  ),
                ),
                // .....end
              ],
            ),
          );
  }
}