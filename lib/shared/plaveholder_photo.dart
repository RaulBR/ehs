import 'dart:io';

import 'package:ehsfocus/theme.dart';
import 'package:flutter/material.dart';

class PhotoWithPlaceholder extends StatelessWidget {
  final File imageFile;
  PhotoWithPlaceholder({this.imageFile});
  @override
  Widget build(BuildContext context) {
    return Container(
      child: imageFile != null
          ? Image.file(
              imageFile,
              height: 200,
            )
          : Icon(
              Icons.photo_camera,
              size: 200,
              color: AppColors.textSecundart,
            ),
    );
  }
}
