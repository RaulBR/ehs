import 'dart:convert';
import 'dart:typed_data';
import 'package:ehsfocus/models/aspect/aspect_photo.dart';
import 'package:ehsfocus/services/repository/local_database/photo_local.db.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'package:ehsfocus/shared/constants.dart';
import 'package:flutter/material.dart';

PhotoLocalDb photoLocalDb = PhotoLocalDb();

class CameraService {
  ImagePicker _imagePicker = ImagePicker();
  Future<PickedFile> openGalery(context) async {
    return await _imagePicker.getImage(
        source: ImageSource.gallery,
        maxHeight: 800,
        maxWidth: 800,
        imageQuality: 50);
  }

  Future<PickedFile> openCamera(context) async {
    return await _imagePicker.getImage(
        source: ImageSource.camera,
        maxHeight: 800,
        maxWidth: 800,
        imageQuality: 50);
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
                    TextButton.icon(
                        onPressed: () async {
                          PickedFile image = await openGalery(context);
                          if (image == null) {
                            return;
                          }
                          getPicture(await photoLocalDb
                              .cocnvertFromFileTOBase64Object(image));
                          Navigator.pop(context);
                        },
                        icon: Icon(Icons.photo_album),
                        label: Text(Labels.galery)),
                    SizedBox(
                      height: 10,
                    ),
                    TextButton.icon(
                        onPressed: () async {
                          PickedFile image = await openCamera(context);
                          getPicture(await photoLocalDb
                              .cocnvertFromFileTOBase64Object(image));
                          Navigator.pop(context);
                        },
                        icon: Icon(Icons.camera_alt),
                        label: Text(Labels.camera)),
                  ],
                ),
              ));
        });
  }

  Future<String> copyPhotoToPhone(AspectPhoto element) async {
    if (element == null) {
      return null;
    }
    if (element.photo == null) {
      return null;
    }
    final encodedStr = element.photo;
    Uint8List bytes = base64.decode(encodedStr);
    String dir = await photoLocalDb.getAppFolder();
    File file = File("$dir" + element.name);
    await file.writeAsBytes(bytes);
    return file.path;
  }
}
