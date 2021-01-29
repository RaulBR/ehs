import 'package:ehsfocus/errors/error_model.dart';
import 'package:ehsfocus/models/area/area_model.dart';
import 'package:ehsfocus/models/area/area_role_model.dart';
import 'package:ehsfocus/models/area/area_step_model.dart';
import 'package:ehsfocus/services/http/http_area.dart';
import 'package:ehsfocus/services/repository/local_database/area_local_db.dart';

import 'package:ehsfocus/shared/constants.dart';

class AreaRepo {
  HttpAreaService _httpAreaService = HttpAreaService();
  AreaLocalDb _areaLocaldb = AreaLocalDb();
  setArea(Area auditin) async {
    try {
      Area area = await _httpAreaService.setArea(auditin);
      _areaLocaldb.setArea(area);
      return area;
    } catch (e) {
      throw GetException(Errors.setError);
    }
  }

  Future<List<Area>> getAreas() async {
    try {
      List<Area> areas = await _areaLocaldb.getAreas();
      if (areas.length > 0) return areas;
      //areas = await _httpAreaService.getAreas();
      if (areas == null) return [];
      _areaLocaldb.setAreasToLocalDb(areas);
      return areas;
    } catch (e) {
      throw GetException(Errors.getError);
    }
  }

  deleteArea(Area auditin) async {
    try {
      await _httpAreaService.deleteArea(auditin);
      _areaLocaldb.deleteArea(auditin);
    } catch (e) {
      throw GetException(Errors.deleteError);
    }
  }

  Future<Area> deleteRole(AreaRole areaRole) async {
    try {
      await _areaLocaldb.deleteRole(areaRole);
      Area area = await _httpAreaService.deleteRole(areaRole);
      setSelectedArea(area);
      return area;
    } catch (e) {
      throw GetException(Errors.deleteError);
    }
  }

  Future<bool> deleteStep(AreaStep step) async {
    try {
      await _areaLocaldb.deleteStep(step);
      // return await _httpAreaService.deleteStep(step);
    } catch (e) {
      return false;
    }
  }

  Future<Area> getAreaById(String id) async {
    return await _areaLocaldb.getAreaById(id);
  }

  Future<Area> getAreaByName(String id) async {
    return await _areaLocaldb.getAreaByName(id);
  }

  Future<Area> setSelectedArea(Area area) async {
    return await _areaLocaldb.setSelectedArea(area);
  }

  Future<Area> setSelectedAreaById(String id) async {
    return await _areaLocaldb.setSelectedAreaById(id);
  }

  Future<Area> getSelectedArea() async {
    return await _areaLocaldb.getSelectedArea();
  }

  Future<Area> setAreaRole(AreaRole role) async {
    return await _areaLocaldb.setAreaRole(role);
  }
}
