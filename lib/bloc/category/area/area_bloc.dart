import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:ehsfocus/models/action/audit_head_modal.dart';
import 'package:ehsfocus/models/area/area_model.dart';
import 'package:ehsfocus/models/area/area_role_model.dart';
import 'package:ehsfocus/models/area/area_step_model.dart';
import 'package:ehsfocus/models/request_models.dart';
import 'package:ehsfocus/services/http/http_area.dart';
import 'package:flutter/cupertino.dart';
import 'package:meta/meta.dart';

part 'area_event.dart';
part 'area_state.dart';

class AreaBloc extends Bloc<AreaEvent, AreaState> {
  Area _area = Area();
  String _preseSelect;
  String _step;
  PaginationObject _requestParams = PaginationObject();
  HttpAreaService httpAreaService = HttpAreaService();
  List<Area> _areasList = [];

  AreaBloc() : super(AreaInitial.initial()) {
    if (_areasList.length == 0) {
      getAreas();
    }
  }

  @override
  Stream<AreaState> mapEventToState(
    AreaEvent event,
  ) async* {
    switch (event.runtimeType) {
      case GetAreasEvent:
        _requestParams.fromRow = 0;
        _requestParams.toRow = 10;
        List<dynamic> ucelessLanguageList =
            await httpAreaService.getAudit(_requestParams);

        _areasList = ucelessLanguageList
            .map((ucelenssLamngauageListElement) => Area(
                id: ucelenssLamngauageListElement.id,
                area: ucelenssLamngauageListElement.area,
                areaInfo: ucelenssLamngauageListElement.areaInfo,
                steps: ucelenssLamngauageListElement.steps,
                roles: ucelenssLamngauageListElement.roles))
            .toList();

        if (_preseSelect != null) {
          setAreaFormByArea(_preseSelect);
        }
        yield AreaListState(areaList: _areasList ?? []);
        break;
      case SearchAreas:
        if (event.areaString == '') {
          yield AreaListState(areaList: _areasList);
          break;
        }
        List<Area> b = [];
        _areasList.forEach((element) {
          if (element.area.contains(event.areaString)) {
            b.add(element);
          }
        });

        yield AreaListState(areaList: b);
        break;
      case GetStepsEvent:
        yield StepListState(stepList: _area.steps ?? []);

        break;
      case DeleteAreaEvent:
        try {
          await httpAreaService.deleteArea(Area(id: event.areaString));
          yield Success();
          getAreas();
          yield AreaListState(areaList: _areasList);
        } catch (e) {}

        break;

      case DeleteRoleEvent:
        _area =
            await httpAreaService.deleteRole(AreaRole(id: event.areaString));
        yield AreaFormState(area: _area);
        try {} catch (e) {}

        break;

      case SetAreaEvent:
        _area = await httpAreaService.setAudit(_area);
        yield Success();
        getAreas();
        yield AreaFormState(area: _area);
        break;

      case UpdateAreaFormEvent:
        yield AreaFormState(area: _area);

        break;
      case SetRoleEvent:
        if (_area.roles == null) {
          _area.roles = [];
        }
        _area.roles.add(event.areaRole);
        yield AreaFormState(area: _area);
        break;
      case EmitSteptsEvent:
        yield StepListState(stepList: _area.steps);
        break;
      case EmitSteptEvent:
        yield SelectedStepState(step: _step);
        break;
      default:
      // yield AreaListState(areaList: _data ?? []);
    }
  }

  deleteRole(String id) {
    add(DeleteRoleEvent(id));
  }

  getAreas() {
    add(GetAreasEvent());
  }

  getStepes() {
    add(GetStepsEvent());
  }

  clearForm() {
    _area = Area();
    add(UpdateAreaFormEvent(area: _area));
  }

  deleteArea(String id) {
    if (id == null || id == '') {
      return;
    }
    add(DeleteAreaEvent(id));
  }

  setAreaFormById(String id) {
    _area = _areasList.firstWhere((element) => element.id == id);
    setAreaForm(_area);
  }

  setAreaFormByArea(String area) {
    if (area == null) {
      return;
    }
    _area = _areasList.firstWhere((element) => element.area == area);
  }

  updatFormByString(String area) {
    if (area == null) {
      return;
    }
    setAreaFormByArea(area);
    add(UpdateAreaFormEvent());
  }

  setAreaForm(Area area) {
    _area = area;
    add(UpdateAreaFormEvent(area: _area));
  }

  searchAreas(String search) {
    if (search == null) {
      return;
    }
    add(SearchAreas(search));
  }

  setRole(AreaRole data) {
    add(SetRoleEvent(data));
  }

  addStep(data) {
    AreaStep step = AreaStep();
    step.step = data;
    _area.steps = _area.steps == null ? [] : _area.steps;
    _area.steps.add(step);
    add(EmitSteptsEvent());
  }

  void selectedStep(String data) {
    _step = data;
    add(EmitSteptEvent());
  }

  void setareaString(area) {
    _preseSelect = area;
  }

  void deleteStep(AreaStep step) {
    add(DeleteSteptEvent());
  }
}
