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

class AuditFormAnimation extends StatefulWidget {
  final Widget child;
  AuditFormAnimation({this.child});
  @override
  _AuditFormAnimationState createState() => _AuditFormAnimationState();
}

class _AuditFormAnimationState extends State<AuditFormAnimation> {
  int count = 0;

  @override
  Widget build(BuildContext context) {
    return AnimatedSwitcher(
      transitionBuilder: (Widget child, Animation<double> animation) {
        return ScaleTransition(
          child: child,
          scale: animation,
        );
      },
      child: widget.child,
      duration: const Duration(milliseconds: 500),
    );
  }
}

class SlideRightRoute extends PageRouteBuilder {
  final Widget page;
  SlideRightRoute({this.page})
      : super(
          pageBuilder: (
            BuildContext context,
            Animation<double> animation,
            Animation<double> secondaryAnimation,
          ) =>
              page,
          transitionsBuilder: (
            BuildContext context,
            Animation<double> animation,
            Animation<double> secondaryAnimation,
            Widget child,
          ) =>
              SlideTransition(
            position: Tween<Offset>(
              begin: const Offset(-1, 0),
              end: Offset.zero,
            ).animate(animation),
            child: child,
          ),
        );
}
