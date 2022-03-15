
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:instagramclone/function/auth.dart';
import 'package:instagramclone/model/user.dart';
import 'package:instagramclone/provider/user_provider.dart';
import 'package:instagramclone/screen/comment_screen.dart';
import 'package:instagramclone/widget/comment.dart';
import 'package:instagramclone/widget/like_animation.dart';
import 'package:provider/provider.dart';

class CardFooter extends StatefulWidget {final snap;
  const CardFooter({
    Key? key,required this.snap,
  }) : super(key: key);

  @override
  State<CardFooter> createState() => _CardFooterState();
}

class _CardFooterState extends State<CardFooter> {
  @override
  Widget build(BuildContext context) {
  final User getUser = Provider.of<UserProvider>(context).getUser;
    return  Container(
            padding: EdgeInsets.symmetric(vertical: 2, horizontal: 8),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    // like
                    LikeAnimation(
                      isAnimating: widget.snap['like'].contains(getUser.uid),
                      smallLike: true,
                      // to animate like button checking if there is userid or not
                      // manche le like garesi red color parney

                      child: widget.snap['like'].contains(getUser.uid)
                          ? IconButton(
                              onPressed: () async {
                                await Auth().updateLike(getUser.uid,
                                    widget.snap['postid'], widget.snap['like']);
                              },
                              icon: const Icon(
                                Icons.favorite,
                                size: 25,
                                color: Colors.red,
                              ))
                          : IconButton(
                              onPressed: () async {
                                await Auth().updateLike(getUser.uid,
                                    widget.snap['postid'], widget.snap['like']);
                              },
                              icon: const FaIcon(FontAwesomeIcons.heart,
                                  size: 25)),
                    ),
                    const SizedBox(
                      width: 3,
                    ),
                    // comment
                    IconButton(
                        onPressed: () => {
                          Navigator.push(context,  MaterialPageRoute<void>(
      builder: (BuildContext context) =>  CommentScreen(snap:widget.snap,),
    ),)
                        },
                        icon: const FaIcon(FontAwesomeIcons.comment, size: 25)),
                    // share
                    IconButton(
                        onPressed: () => {},
                        icon: const Icon(Icons.send, size: 25)),
                    // bookmark post
                    Expanded(
                      child: Align(
                        alignment: Alignment.centerRight,
                        child: IconButton(
                            onPressed: () => {},
                            icon: const Icon(Icons.bookmark_border_outlined,
                                size: 25)),
                      ),
                    )
                  ],
                ),
                // number of likes
                Padding(
                  padding: EdgeInsets.symmetric(vertical: 2, horizontal: 8),
                  child: Text(widget.snap['like'].length<=1?
                    ('${widget.snap['like'].length} like'):('${widget.snap['like'].length} likes'),
                    style: TextStyle(fontWeight: FontWeight.w700, fontSize: 15),
                  ),
                ),
                // user caption
                Container(
                  width: double.infinity,
                  padding: EdgeInsets.symmetric(vertical: 2, horizontal: 8),
                  child: Row(
                    children: [
                      Text(
                        widget.snap['username'],
                        style: TextStyle(
                            fontWeight: FontWeight.w700, fontSize: 15),
                      ),
                      SizedBox(
                        width: 7,
                      ),
                      Flexible(
                          child: Text(
                        widget.snap['description'],
                        maxLines: 10,
                        style: TextStyle(
                            fontWeight: FontWeight.w700, fontSize: 15),
                      )),
                    ],
                  ),
                ),
                // comment
                Comment(snap: widget.snap,),
              
                // end of comment
              ],
            ),
          );
  }
}
