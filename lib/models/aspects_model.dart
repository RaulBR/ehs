import 'dart:io';
import 'action_model.dart';

class Aspect {
  String category;
  String comment;
  File photo;
  int auditId;
  String type;
  AuditAction action;
  Aspect({this.category, this.comment , this.photo, this.auditId, this.type, this.action});
}