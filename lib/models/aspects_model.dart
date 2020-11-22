import 'package:ehsfocus/models/audit_head_modal.dart';

import 'action_model.dart';

class Aspect {
  String id;
  String category;
  String comment;
  String categoryType;
  String equipment;
  String auditId;
  String type;
  String status;
  String auditActionId;
  String createdDate;
  AuditHead audit;
  AuditAction action;
  List<AspectPhoto> photos;
  Aspect(
      {this.id,
      this.category,
      this.comment,
      this.auditId,
      this.type,
      this.status,
      this.action,
      this.audit,
      this.photos});

  Aspect.fromJson(parsedJson) {
    if (parsedJson == null) {
      return;
    }
    id = parsedJson['id']?.toString();
    category = parsedJson['category']?.toString();
    comment = parsedJson['comment']?.toString();
    auditId = parsedJson['auditId']?.toString();
    equipment = parsedJson['equipment']?.toString();
    categoryType = parsedJson['categoryType']?.toString();
    type = parsedJson['type']?.toString();
    status = parsedJson['status']?.toString();
    auditActionId = parsedJson['auditActionId']?.toString();
    createdDate = parsedJson['createdDate']?.toString();
    audit = parsedJson['audit'] == null
        ? null
        : AuditHead.fromJson(parsedJson['audit']);
    action = parsedJson['auditAction'] == null
        ? null
        : AuditAction.fromJson(parsedJson['auditAction']);
    if (parsedJson['photos'] != null && parsedJson['photos'].length > 0) {
      photos = (parsedJson['photos'] as List<dynamic>)
          .map((i) => AspectPhoto.fromJson(i))
          .toList();
    }
  }

  Map<String, dynamic> toJson() => {
        "id": id ?? null,
        "category": category ?? null,
        "comment": comment ?? null,
        "auditId": auditId ?? null,
        "type": type ?? null,
        "categoryType": categoryType ?? null,
        "status": status ?? null,
        "auditActionId": auditActionId ?? null,
        "equipment": equipment ?? null,
        "auditAction": action == null ? null : action.toJson(),
        "photos": photos == null
            ? []
            : photos.map((AspectPhoto data) => data.toJson()).toList(),
      };
}

class AspectPhoto {
  String photo;
  String id;
  String name;
  String type;
  String size;
  String aspectId;
  String createdDate;
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
