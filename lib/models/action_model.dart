import 'package:ehsfocus/models/audit_head_modal.dart';
import 'package:ehsfocus/models/aspects_model.dart';

class Audit {
  AuditHead auditHead;
  List<Aspect> positiveAspects;
  List<Aspect> negativeAspects;

  Audit({this.auditHead, this.positiveAspects, this.negativeAspects});

  Map<String, dynamic> toJson() => {
        "auditHead": auditHead == null ? null : auditHead.toJson(),
        "negativeAspects": negativeAspects == null
            ? []
            : negativeAspects.map((Aspect data) => data.toJson()).toList(),
        "positiveAspects": positiveAspects == null
            ? []
            : positiveAspects.map((Aspect data) => data.toJson()).toList(),
      };

  String getJsonString(List<Aspect> aspects) {
    String values;
    return aspects == null || aspects.length == 0 ? "[]" : "[$values ??]";
  }

  Audit.fromJson(Map<String, dynamic> parsedJson) {
    if (parsedJson == null || parsedJson['auditHead'] == null) {
      auditHead = null;
      positiveAspects = [];
      negativeAspects = [];
      return;
    }
    auditHead = AuditHead.fromJson(parsedJson['auditHead']);
    if (parsedJson['positiveAspects'] == null) {
      positiveAspects = [];
    } else {
      positiveAspects = (parsedJson['positiveAspects'] as List<dynamic>)
          .map((i) => Aspect.fromJson(i))
          .toList();
    }

    if (parsedJson['negativeAspects'] == null) {
      negativeAspects = [];
    } else {
      negativeAspects = (parsedJson['negativeAspects'] as List<dynamic>)
          .map((i) => Aspect.fromJson(i))
          .toList();
    }
  }
}

class AuditAction {
  String id;
  bool imidiatAcction;
  String responsible;
  String limitDate;
  String comment;
  String type;
  AuditAction(
      {this.imidiatAcction, this.comment, this.limitDate, this.responsible});

  Map<String, dynamic> toJson() => {
        "Id": id,
        "imidiatAcction": imidiatAcction ?? false,
        "limitDate": limitDate,
        "comment": comment,
        "responsible": responsible
      };

  AuditAction.fromJson(parsedJson) {
    id = parsedJson['id'].toString();
    imidiatAcction = parsedJson['imidiatAcction'];
    limitDate = parsedJson['limitDate'].toString();
    comment = parsedJson['comment'].toString();
    responsible = parsedJson['responsible'].toString();
  }

  isNotEmpty() {
    return imidiatAcction != null ||
        limitDate != null ||
        comment != null ||
        responsible != null;
  }
}

class AuditRequest {
  AuditHead auditHead;
  Aspect aspect;
  AuditRequest({this.aspect, this.auditHead});

  AuditRequest.fromJson(Map<String, dynamic> parsedJson) {
    if (parsedJson == null || parsedJson['auditHead'] == null) {
      return;
    }
    auditHead = AuditHead.fromJson(parsedJson['auditHead']);
    if (parsedJson['aspect'] == null) {
      aspect = null;
      return;
    }
    aspect = Aspect.fromJson(parsedJson['aspect']);
  }

  Map<String, dynamic> toJson() => {
        "auditHead": auditHead.toJson(),
        "aspect": aspect.toJson(),
      };
}
