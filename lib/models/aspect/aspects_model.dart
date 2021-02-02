import 'package:ehsfocus/models/action/audit_action_model.dart';
import 'package:ehsfocus/models/aspect/aspect_photo.dart';
import 'package:ehsfocus/models/action/audit_head_modal.dart';
import 'package:hive/hive.dart';
part '../hive_generated.dart/aspects_model.g.dart';

@HiveType(typeId: 13)
class Aspect {
  @HiveField(0)
  String id;
  @HiveField(1)
  String category;
  @HiveField(2)
  String comment;
  @HiveField(3)
  String rejectComment;
  @HiveField(4)
  String categoryType;
  @HiveField(5)
  String equipment;
  @HiveField(6)
  String auditId;
  @HiveField(7)
  String type;
  @HiveField(8)
  String status;
  @HiveField(9)
  String auditActionId;
  @HiveField(10)
  String createdDate;
  @HiveField(11)
  AuditHead audit;
  @HiveField(12)
  AuditAction action;
  @HiveField(13)
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
    rejectComment = parsedJson['rejectComment']?.toString();
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
        "rejectComment": rejectComment,
        "auditActionId": auditActionId ?? null,
        "equipment": equipment ?? null,
        "auditAction": action == null ? null : action.toJson(),
        "photos": photos == null
            ? []
            : photos.map((AspectPhoto data) => data.toJson()).toList(),
      };
}
