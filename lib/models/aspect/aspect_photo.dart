import 'package:hive/hive.dart';
part '../hive_generated.dart/aspect_photo.g.dart';

@HiveType(typeId: 12)
class AspectPhoto {
  @HiveField(0)
  String id;
  @HiveField(1)
  String name;
  @HiveField(2)
  String type;
  @HiveField(3)
  String size;
  @HiveField(4)
  String aspectId;
  @HiveField(5)
  String createdDate;
  @HiveField(6)
  String photo;
  AspectPhoto({this.id, this.name, this.photo, this.size, this.type});
  AspectPhoto.fromJson(parsedJson) {
    if (parsedJson == null) {
      return;
    }
    if (parsedJson['photo'] != null) {
      photo = parsedJson['photo'].toString();
    }

    id = parsedJson['id'] == null ? null : parsedJson['id'].toString();
    name = parsedJson['name'].toString();
    type = parsedJson['type'].toString();
    createdDate = parsedJson['createdDate'].toString();
    size = parsedJson['size'].toString();
  }
  Map<String, dynamic> toJson() => {
        "photo": photo ?? null,
        "id": id ?? null,
        "name": name ?? null,
        "type": type ?? null,
        "size": size ?? null,
        "aspectId": aspectId ?? null
      };
}
