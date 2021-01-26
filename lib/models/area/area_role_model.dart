import 'package:ehsfocus/models/employee/employee_model.dart';
import 'package:hive/hive.dart';
part '../hive_generated.dart/area_role_model.g.dart';

@HiveType(typeId: 10)
class AreaRole {
  @HiveField(0)
  String role;
  @HiveField(1)
  String id;
  @HiveField(2)
  Employee responsible;
  AreaRole({this.id, this.role, this.responsible});
  AreaRole.fromJson(Map<String, dynamic> parsedJson) {
    id = parsedJson['id'].toString();
    role = parsedJson['role'].toString();
    responsible = parsedJson['responsible'] == null
        ? null
        : Employee.fromJson(parsedJson['responsible']);
  }
  Map<String, dynamic> toJson() =>
      {"id": id, "role": role, "responsible": responsible?.toJson()};
}
