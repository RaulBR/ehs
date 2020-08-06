import 'dart:convert';
import 'package:ehsfocus/theme.dart';
import 'package:flutter/material.dart';

class PhotoWithPlaceholder extends StatelessWidget {
  final String image;
  final Function remove;
  final Function open;
  PhotoWithPlaceholder({this.image, this.remove, this.open});
  @override
  Widget build(BuildContext context) {

    return SizedBox(
      child: Container(
        child: image != null
            ? Stack(alignment: AlignmentDirectional.topEnd, children: [
                Image.memory(
                  (base64Decode(image)),
                  height: 200,
                ),
                GestureDetector(
                  onTap: () {
                    remove();
                  },
                  child: Icon(Icons.close),
                ),
              ],)
            : GestureDetector(
                onTap: () {
                  open();
                },
                child: Icon(
                  Icons.photo_camera,
                  size: 200,
                  color: AppColors.textSecundart,
                ),
              ),
      ),
    );
  }
}
