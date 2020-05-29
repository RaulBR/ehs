import 'package:ehsfocus/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class Loading extends StatelessWidget {
  final double size;
  Loading({this.size});
  @override
  Widget build(BuildContext context) {
    return Container(
        color: AppColors.primary,
        child: Center(
            child: SpinKitFoldingCube(
          color: AppColors.icons,
          size: size != null ? size : 50.0,
        )));
  }
}


class Loading2 extends StatefulWidget {

  @override
  _Loading2State createState() => _Loading2State();
}

class _Loading2State extends State<Loading2> {

    void initState() {
    super.initState();
        Future.delayed(const Duration(seconds: 2), () {
        Navigator.pop(context);
      // Here you can write your code for open new view
    });

  }
  @override
  Widget build(BuildContext context) {
     return Loading();
  }
}


class LoadingSimbol extends StatelessWidget {
  final double size;
  LoadingSimbol({this.size});
  @override
  Widget build(BuildContext context) {
    return  SpinKitFoldingCube(
          color: AppColors.icons,
          size: size != null ? size : 50.0,
        );
  }
}