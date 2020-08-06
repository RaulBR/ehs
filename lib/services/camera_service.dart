import 'dart:convert';
import 'dart:typed_data';

import 'package:ehsfocus/models/aspects_model.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'package:ehsfocus/shared/constants.dart';
import 'package:flutter/material.dart';

class CameraService {
  Future<File> openGalery(context) async {
    return await ImagePicker.pickImage(
        source: ImageSource.gallery, maxHeight: 800, maxWidth: 800);
  }

  Future<File> openCamera(context) async {
    return await ImagePicker.pickImage(
        source: ImageSource.camera, maxHeight: 800, maxWidth: 800);
  }

  Future<AspectPhoto> cocnvertFromFileTOBase64(File path) async {
    if (path == null) {
      return null;
    }

    AspectPhoto _aslectPhoto = AspectPhoto();
    String fileName = path.path.split('/').last;
    _aslectPhoto.name = fileName;
    _aslectPhoto.type = fileName.split('.')[1];
    dynamic size = await path.length();
    _aslectPhoto.size = size.toString();
    Uint8List imageBytes = path.readAsBytesSync();
    //     debugPrint(imageBytes.toString() , wrapWidth: 1024);
    String base64Image = base64Encode(imageBytes);
    _aslectPhoto.photo = base64Image; // base64Image;
    return _aslectPhoto;
  }

  handleShowDialog(BuildContext context, Function getPicture) {
    return showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
              title: Text(Labels.chose),
              content: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    FlatButton.icon(
                        onPressed: () async {
                          File image = await openGalery(context);
                          getPicture(await cocnvertFromFileTOBase64(image));
                          Navigator.pop(context);
                        },
                        icon: Icon(Icons.photo_album),
                        label: Text(Labels.galery)),
                    SizedBox(
                      height: 10,
                    ),
                    FlatButton.icon(
                        onPressed: () async {
                          File image = await openCamera(context);
                          getPicture(await cocnvertFromFileTOBase64(image));
                          Navigator.pop(context);
                        },
                        icon: Icon(Icons.camera_alt),
                        label: Text(Labels.camera)),
                  ],
                ),
              ));
        });
  }
}
