import 'package:ehsfocus/models/employee_model.dart';

class Area {
  String id;
  String area;
  String areaInfo;
  List<AreaStep> steps;
  List<AreaRole> roles;

  Area({this.id, this.area, this.areaInfo, this.steps, this.roles});

  Map<String, dynamic> toJson() => {
        "id": id,
        "area": area,
        "areaInfo": areaInfo,
        "steps": steps == null
            ? []
            : steps.map((AreaStep data) => data.toJson()).toList(),
        "roles": roles == null
            ? []
            : roles.map((AreaRole data) => data.toJson()).toList()
      };

  Area.fromJson(Map<String, dynamic> parsedJson) {
    id = parsedJson['id'].toString();
    area = parsedJson['area'].toString();
    areaInfo = parsedJson['areaInfo'].toString();

    steps = parsedJson['steps'] == null
        ? []
        : (parsedJson['steps'] as List<dynamic>)
            .map((i) => AreaStep.fromJson(i))
            .toList();

    roles = parsedJson['roles'] == null
        ? []
        : (parsedJson['roles'] as List<dynamic>)
            .map((i) => AreaRole.fromJson(i))
            .toList();
  }
}

class AreaStep {
  String id;
  String step;
  String stepinfo;
  String areaId;
  AreaStep({this.id, this.areaId, this.stepinfo, this.step});

  Map<String, dynamic> toJson() =>
      {"id": id, "step": step, "stepinfo": stepinfo, "areaId": areaId};

  AreaStep.fromJson(Map<String, dynamic> parsedJson) {
    id = parsedJson['id'].toString();
    step = parsedJson['step'].toString();
    areaId = parsedJson['areaId'].toString();
    stepinfo = parsedJson['stepinfo'].toString();
    // steps =
  }
}

class AreaRole {
  String role;
  String id;
  Employee responsable;
  AreaRole({this.id, this.role, this.responsable});
  AreaRole.fromJson(Map<String, dynamic> parsedJson) {
    id = parsedJson['id'].toString();
    role = parsedJson['role'].toString();
    responsable = parsedJson['responsable'] == null
        ? null
        : Employee.fromJson(parsedJson['responsable']);
  }
  Map<String, dynamic> toJson() =>
      {"id": id, "role": role, "responsable": responsable?.toJson()};
}
