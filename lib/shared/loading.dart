import 'package:ehsfocus/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class Loading extends StatelessWidget {
  final double size;
  final Color color;
  Loading({this.size, this.color});
  @override
  Widget build(BuildContext context) {
    return Container(
        color: color == null ? AppColors.primary : color,
        child: Center(
            child: SpinKitFoldingCube(
          color: color == null ? AppColors.icons : AppColors.primary,
          size: size != null ? size : 50.0,
        )));
  }
}

class LoadingSimbol extends StatelessWidget {
  final double size;
  LoadingSimbol({this.size});
  @override
  Widget build(BuildContext context) {
    return SpinKitFoldingCube(
      color: AppColors.icons,
      size: size != null ? size : 50.0,
    );
  }
}
