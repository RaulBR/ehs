import 'package:ehsfocus/models/employee/employee_model.dart';
import 'package:hive/hive.dart';
part '../hive_generated.dart/audit_action_model.g.dart';

@HiveType(typeId: 9)
class AuditAction {
  @HiveField(0)
  String id;
  @HiveField(1)
  bool imidiatAcction;
  @HiveField(2)
  Employee responsible;
  @HiveField(3)
  String limitDate;
  @HiveField(4)
  String comment;
  @HiveField(5)
  String type;
  AuditAction(
      {this.imidiatAcction, this.comment, this.limitDate, this.responsible});

  Map<String, dynamic> toJson() => {
        "id": id ?? null,
        "imidiatAcction": imidiatAcction ?? false,
        "limitDate": limitDate ?? null,
        "comment": comment ?? null,
        "responsible": responsible.toJson()
      };

  AuditAction.fromJson(parsedJson) {
    id = parsedJson['id'].toString();
    imidiatAcction = parsedJson['imidiatAcction'];
    limitDate = parsedJson['limitDate']?.toString();
    comment = parsedJson['comment']?.toString();
    responsible = parsedJson['responsible'] != null
        ? Employee.fromJson(parsedJson['responsible'])
        : null;
  }

  isNotEmpty() {
    return imidiatAcction != null ||
        limitDate != null ||
        comment != null ||
        responsible != null;
  }
}
