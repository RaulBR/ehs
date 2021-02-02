import 'package:hive/hive.dart';
part '../hive_generated.dart/area_step_model.g.dart';

@HiveType(typeId: 11)
class AreaStep {
  @HiveField(0)
  String id;
  @HiveField(1)
  String step;
  @HiveField(2)
  String stepinfo;
  @HiveField(3)
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
