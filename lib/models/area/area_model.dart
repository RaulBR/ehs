import 'package:ehsfocus/models/area/area_role_model.dart';
import 'package:ehsfocus/models/area/area_step_model.dart';
import 'package:hive/hive.dart';
part '../hive_generated.dart/area_model.g.dart';

@HiveType(typeId: 3)
class Area {
  @HiveField(0)
  String id;
  @HiveField(1)
  String area;
  @HiveField(2)
  String areaInfo;
  @HiveField(3)
  List<AreaStep> steps;
  @HiveField(4)
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
