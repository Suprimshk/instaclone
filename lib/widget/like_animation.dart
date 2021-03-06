import 'package:flutter/material.dart';

class LikeAnimation extends StatefulWidget {
  final Widget child;
  final bool smallLike;
  final bool isAnimating;
  final VoidCallback? isEnd;
  final Duration duration;

  const LikeAnimation(
      {Key? key,
      required this.child,
      required this.smallLike,
      required this.isAnimating,
       this.isEnd,
       this.duration=const Duration(milliseconds:150)})
      : super(key: key);

  @override
  _LikeAnimationState createState() => _LikeAnimationState();
}

class _LikeAnimationState extends State<LikeAnimation>
    with SingleTickerProviderStateMixin {
  late AnimationController controller;
  late Animation<double> scale;
  @override
  void initState() {
    super.initState();
    controller = AnimationController(
        vsync: this,
        duration: Duration(milliseconds:
         widget.duration.inMilliseconds ~/ 2
         ));
        scale=Tween<double>(begin: 1,end: 1.2).animate(controller);
      
  }

  @override
  void didUpdateWidget(covariant LikeAnimation oldwidget)
  {
    super.didUpdateWidget(oldwidget);
      if(widget.isAnimating!=oldwidget.isAnimating){
          startAnimation();

        }
  }
  startAnimation()async {
if(widget.isAnimating || widget.smallLike){
  await controller.forward();
   await controller.reverse();
    await Future.delayed(const Duration(milliseconds: 200));
    if (widget.isEnd != null){
      widget.isEnd!();
    }
}
  }
  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }
  Widget build(BuildContext context) {
    return ScaleTransition(
      scale:scale ,
      child: widget.child,
    );
  }
}
