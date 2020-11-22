import 'package:flutter/material.dart';

class AnimationWrapper extends StatelessWidget {
  final Widget child;
  AnimationWrapper({this.child});
  @override
  Widget build(BuildContext context) {
    return AnimatedSwitcher(
        duration: const Duration(milliseconds: 500),
        transitionBuilder: (Widget child, Animation<double> animation) {
          // return FadeTransition(opacity:Tween(begin:0.0, end: 1.0).animate(animation) ,
          return SlideTransition(
              position:
                  Tween<Offset>(begin: Offset(0.0, 2.0), end: Offset(0.0, 0.0))
                      .animate(animation),
              child: child);
        },
        child: child);
  }
}

class FadeAnimationWrapper extends StatelessWidget {
  final Widget child;
  FadeAnimationWrapper({this.child});
  @override
  Widget build(BuildContext context) {
    return AnimatedSwitcher(
        duration: const Duration(milliseconds: 500),
        transitionBuilder: (Widget child, Animation<double> animation) {
          return FadeTransition(
              opacity: Tween(begin: 0.0, end: 1.0).animate(animation),
              child: child);
        },
        child: child);
  }
}
