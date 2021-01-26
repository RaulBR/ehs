import 'package:ehsfocus/models/action/audit_head_modal.dart';
import 'package:ehsfocus/models/aspect/aspects_model.dart';
import 'package:hive/hive.dart';
part '../hive_generated.dart/audit_model.g.dart';

@HiveType(typeId: 8)
class Audit {
  @HiveField(0)
  AuditHead auditHead;
  @HiveField(1)
  List<Aspect> positiveAspects;
  @HiveField(2)
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
