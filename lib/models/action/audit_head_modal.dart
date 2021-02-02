import 'package:ehsfocus/models/employee/employee_model.dart';
import 'package:hive/hive.dart';
part '../hive_generated.dart/audit_head_modal.g.dart';

@HiveType(typeId: 4)
class AuditHead {
  @HiveField(0)
  String id;
  @HiveField(1)
  String area;
  @HiveField(2)
  String step;
  @HiveField(3)
  String sector;
  @HiveField(4)
  String auditType;
  @HiveField(5)
  String auditStatus;
  @HiveField(6)
  Employee employee;
  @HiveField(7)
  String createdDate;
  AuditHead({this.id, this.area, this.step, this.sector, this.auditStatus});

  Map<String, dynamic> toJson() => {
        "area": area,
        "step": step,
        "sector": sector,
        "auditType": auditType,
        "id": id,
        "auditStatus": auditStatus
      };

  AuditHead fromJson(Map<String, dynamic> parsedJson) {
    return AuditHead.fromJson(parsedJson);
  }

  AuditHead.fromJson(Map<String, dynamic> parsedJson) {
    id = parsedJson['id'].toString();
    area = parsedJson['area']?.toString();
    step = parsedJson['step']?.toString();
    auditType = parsedJson['auditType']?.toString();
    sector =
        parsedJson['sector'] == null ? null : parsedJson['sector'].toString();
    auditStatus = parsedJson['auditStatus'].toString();
    createdDate = parsedJson['createdDate'].toString();
    employee = parsedJson['employee'] == null
        ? null
        : Employee.fromJson(parsedJson['employee']);
  }
}
