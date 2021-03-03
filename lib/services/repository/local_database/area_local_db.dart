import 'package:ehsfocus/errors/error_model%20copy.dart';
import 'package:ehsfocus/models/area/area_model.dart';
import 'package:ehsfocus/models/area/area_role_model.dart';
import 'package:ehsfocus/models/area/area_step_model.dart';
import 'package:ehsfocus/services/repository/local_database/repo.dart';
import 'package:ehsfocus/shared/constants.dart';
import 'package:hive/hive.dart';

class AreaLocalDb extends HiveRepo {
  setArea(Area auditin) async {
    try {
      Box<Area> areaBox = await _getAreaBox();
      areaBox.put(auditin.id, auditin);
      return auditin;
    } catch (e) {
      throw GetException(Errors.setError);
    }
  }

  Future<List<Area>> getAreas() async {
    try {
      Box<Area> areaBox = await _getAreaBox();
      if (areaBox.length > 0) return convertBoxToList<Area>(areaBox);
      return [];
    } catch (e) {
      throw GetException(Errors.getError);
    }
  }

  Future<List<Area>> setAreasToLocalDb(List<Area> areas) async {
    Box<Area> areaBox = await _getAreaBox();
    if (areas == null) return [];
    if (areas.length > 0)
      areas.forEach((element) {
        areaBox.put(element.id, element);
      });
    return areas;
  }

  deleteArea(Area auditin) async {
    try {
      Box<Area> areaBox = await _getAreaBox();
      areaBox.delete(auditin.id);
    } catch (e) {
      throw GetException(Errors.deleteError);
    }
  }

  Future<Area> deleteRole(AreaRole areaRole) async {
    try {
      Box<Area> areaBox = await _getAreaBox();
      List<Area> areas = getLocalAreas(areaBox);
      Area area = areas.firstWhere((area) {
        bool isDone = false;
        area.roles.removeWhere((role) {
          if (role.id == areaRole.id) {
            isDone = true;
            return isDone;
          }
          return false;
        });
        return isDone;
      });
      setSelectedArea(area);
      return area;
    } catch (e) {
      throw GetException(Errors.deleteError);
    }
  }

  Future<bool> deleteStep(AreaStep step) async {
    try {
      Box<Area> areaBox = await _getAreaBox();
      List<Area> areas = getLocalAreas(areaBox);
      bool isDone = false;
      Area area = areas.firstWhere((area) {
        area.steps.removeWhere((stepElement) {
          if (stepElement.id == step.id) {
            isDone = true;
            return true;
          }
          return false;
        });
        return isDone;
      });
      if (isDone) {
        setSelectedArea(area);
      }

      return true;
    } catch (e) {
      return false;
    }
  }

  Future<Area> getAreaByName(String name) async {
    List<Area> areas = await getAreas();
    Area area = areas.firstWhere((element) => element.area == name);
    return area;
  }

  Future<Area> getAreaById(String id) async {
    if (id == null) return Area();
    Box<Area> areaBox = await _getAreaBox();
    Area area = areaBox.get(id);
    return area;
  }

  List<Area> getLocalAreas(Box<Area> areaBox) {
    // aconvertBoxToList<Area>(areaBox)
    return areaBox.values as List<Area>;
  }

  Future<Area> setSelectedArea(Area area) async {
    Box<Area> areaBox = await initiateBox(HiveName.selectedArea);
    areaBox.put(0, area);
    return area;
  }

  Future<Area> setSelectedAreaById(String id) async {
    Area area = await getAreaById(id);
    Box<Area> areaBox = await initiateBox(HiveName.selectedArea);
    areaBox.put(0, area);
    return area;
  }

  Future<Area> getSelectedArea() async {
    Box<Area> areaBox = await initiateBox(HiveName.selectedArea);
    Area area = areaBox.get(0);
    return area == null ? Area() : area;
  }

  Future<Area> setAreaRole(AreaRole role) async {
    Area area = await getSelectedArea();
    if (area.roles == null) area.roles = [];
    area.roles.add(role);
    return await setSelectedArea(area);
  }

  Future<void> deleteAreas() async {
    Box<Area> areaBox = await _getAreaBox();
    areaBox.clear();
  }

  Future<Box<Area>> _getAreaBox() async {
    return await initiateBox(HiveName.area);
  }
}
