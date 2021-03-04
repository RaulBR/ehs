import 'package:ehsfocus/theme.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class SnackBarSerice {
  void showToast(BuildContext context, String error) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        backgroundColor: AppColors.errorColor,
        content: Text(error),
      ),
    );
  }
}
