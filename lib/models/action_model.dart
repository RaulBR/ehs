import 'package:ehsfocus/models/area_model.dart';
import 'package:ehsfocus/models/aspects_model.dart';

class Audit {
  Area area;
  List<Aspect> positiveAspects;
  List<Aspect> negativeAspects;
  AuditAction auditAction;
  Audit(
      {this.area,
      this.positiveAspects,
      this.negativeAspects,
      this.auditAction});

}

class AuditAction{
  bool imidiatAcction;
  String responsible;
  String limitDate;
  String createdDate;
  String comment;
  String type;
  AuditAction(
      {this.imidiatAcction, this.comment, this.limitDate, this.responsible});

  Map<String, dynamic> toJson() => {
        "imidiatAcction": imidiatAcction,
        "limitDate": limitDate,
        "createdDate": createdDate,
        "comment": comment,
        "responsible": responsible
      };

  AuditAction.fromJson(Map<String, dynamic> parsedJson) {
    imidiatAcction = parsedJson['midiatAcction'].toBoolean();
    limitDate = parsedJson['limitDate'].toString();
    createdDate = parsedJson['createdDate'].toString();
    comment = parsedJson['comment'].toString();
    responsible = parsedJson['responsible'].toString();
    
  }
}
