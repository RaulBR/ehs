import 'package:ehsfocus/models/aspect/aspect_photo.dart';
import 'package:ehsfocus/models/aspect/aspects_model.dart';
import 'package:ehsfocus/services/http/http_photo.dart';
import 'package:ehsfocus/services/repository/local_database/photo_local.db.dart';

class PhotoRepo {
  final _httpPhotoService = HttpPhotoService();
  PhotoLocalDb _photoLocalDb = PhotoLocalDb();
  removePhoto(AspectPhoto aspectPhoto) async {
    return await _photoLocalDb.removePhoto(aspectPhoto);
  }

  Future<AspectPhoto> getFromFile(String photoName) async {
    AspectPhoto aspectPhoto = await _photoLocalDb.getFromFile(photoName);
    return aspectPhoto;
  }

  Future<List<AspectPhoto>> getPhotosByAspectId(Aspect photoSorce) async {
    List<AspectPhoto> photos = [];
    photos = await getPhotosFromLocalDb(photoSorce, photos);
    if (photos.length > 0) {
      return photos;
    }

    List<AspectPhoto> data =
        await _httpPhotoService.getPhotosByAspectId(photoSorce);
    data.forEach((element) {
      photos.add(element);
      _photoLocalDb.copyPhotoToPhone(element);
    });
    return photos;
  }

  Future<List<AspectPhoto>> getPhotosFromLocalDb(
      Aspect photoSorce, List photos) async {
    if (photoSorce != null) {
      if (photoSorce.photos != null) {
        if (photoSorce.photos.length > 0) {
          photoSorce.photos.forEach((element) async {
            dynamic photdata = await getFromFile(element.name);
            photos.add(photdata);
          });
        }
      }
    }
    return photos;
  }

  deleteAspectPhoto(photoSorce) async {
    await _httpPhotoService.deleteAspectPhoto(photoSorce);
    await removePhoto(photoSorce);
  }
}
