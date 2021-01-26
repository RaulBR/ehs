import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';

import 'package:ehsfocus/models/aspect/aspect_photo.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';

class PhotoLocalDb {
  Future<File> moveFile(File sourceFile, String newPath) async {
    try {
      // prefer using rename as it is probably faster
      return await sourceFile.rename(newPath);
    } on FileSystemException catch (e) {
      // if rename fails, copy the source file and then delete it
      print(e);
      final newFile = await sourceFile.copy(newPath);
      await sourceFile.delete();
      return newFile;
    }
  }

  removePhoto(AspectPhoto aspectPhoto) async {
    try {
      String photoName = aspectPhoto.name;
      String dir = await getAppFolder();
      File f = File('$dir/$photoName');
      return await f.delete();
    } catch (e) {
      return null;
    }
  }

  Future<AspectPhoto> getFromFile(String filename) async {
    try {
      String dir = await getAppFolder();
      File f = new File('$dir/$filename');
      return cocnvertFromFileTOBase64(f);
    } catch (e) {
      print(e);
      return null;
    }
  }

  Future<String> getAppFolder() async {
    try {
      final Directory _appDocDir = await getApplicationDocumentsDirectory();
      final Directory _appDocDirFolder =
          Directory('${_appDocDir.path}/EHS-Focus/');
      if (await _appDocDirFolder.exists()) {
        return '${_appDocDir.path}/EHS-Focus/';
      }

      await _appDocDirFolder.create(recursive: true);
      return '${_appDocDir.path}/EHS-Focus/';
    } catch (e) {
      print(e);
      return '';
    }
  }

  Future<File> preProcessLocation(PickedFile path) async {
    File f = new File(path.path);
    String newPath = await getAppFolder();
    String type = path.path.split('/').last.split('.')[1];
    String newFilename = DateTime.now().millisecondsSinceEpoch.toString();
    f = await moveFile(f, "$newPath/$newFilename.$type");
    return f;
  }

  Future<AspectPhoto> cocnvertFromFileTOBase64Object(PickedFile path) async {
    if (path == null) {
      return null;
    }
    File f = await preProcessLocation(path);
    return cocnvertFromFileTOBase64(f);
  }

  Future<AspectPhoto> cocnvertFromFileTOBase64(File path) async {
    if (path == null) {
      return null;
    }
    try {
      AspectPhoto _aslectPhoto = AspectPhoto();
      String fileName = path.path.split('/').last;
      dynamic size = path.lengthSync();
      fileName = path.path.split('/').last;
      _aslectPhoto.type = fileName.split('.')[1];
      _aslectPhoto.name = fileName;
      _aslectPhoto.size = size.toString();
      Uint8List imageBytes = path.readAsBytesSync();
      String base64Image = base64Encode(imageBytes);
      _aslectPhoto.photo = base64Image; // base64Image;
      return _aslectPhoto;
    } catch (e) {
      return null;
    }
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
    String dir = await getAppFolder();
    File file = File("$dir" + element.name);
    await file.writeAsBytes(bytes);
    return file.path;
  }
}
