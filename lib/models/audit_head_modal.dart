import 'package:ehsfocus/models/employee_model.dart';

class AuditHead {
  String id;
  String area;
  String step;
  String sector;
  String auditStatus;
  Employee employee;

  AuditHead({this.id, this.area, this.step, this.sector, this.auditStatus});

  Map<String, dynamic> toJson() => {
        "area": area,
        "step": step,
        "sector": sector,
        "id": id,
        "auditStatus": auditStatus
      };

  AuditHead fromJson(Map<String, dynamic> parsedJson) {
    return AuditHead.fromJson(parsedJson);
  }

  AuditHead.fromJson(Map<String, dynamic> parsedJson) {
    id = parsedJson['id'].toString();
    area = parsedJson['area'].toString();
    step = parsedJson['step'].toString();
    sector =
        parsedJson['sector'] == null ? null : parsedJson['sector'].toString();
    auditStatus = parsedJson['auditStatus'].toString();
    print(parsedJson['employee']);
    employee = parsedJson['employee'] == null
        ? null
        : Employee.fromJson(parsedJson['employee']);
  }
}
