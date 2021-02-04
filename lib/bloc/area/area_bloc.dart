import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:ehsfocus/models/action/audit_head_modal.dart';
import 'package:ehsfocus/models/area/area_model.dart';
import 'package:ehsfocus/models/area/area_role_model.dart';
import 'package:ehsfocus/models/area/area_step_model.dart';
import 'package:ehsfocus/services/repository/area_repo.dart';
import 'package:flutter/cupertino.dart';
import 'package:meta/meta.dart';

part 'area_event.dart';
part 'area_state.dart';

class AreaBloc extends Bloc<AreaEvent, AreaState> {
  Area _area = Area();
  String _preseSelect;
  String _step;

  AreaRepo _areaRepo = AreaRepo();
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
        List<Area> _areasList = await _areaRepo.getAreas();
        if (_preseSelect != null) {
          setAreaFormByArea(_preseSelect);
        }

        yield AreaListState(areaList: _areasList ?? []);
        yield AreaFormState(area: _area, areaList: _areasList);
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
        List<Area> _areasList = await _areaRepo.getAreas();
        _area =
            _areasList.firstWhere((element) => element.area == event.area.area);
        yield StepListState(stepList: _area.steps ?? []);

        break;
      case DeleteAreaEvent:
        try {
          await _areaRepo.deleteArea(Area(id: event.areaString));
          yield Success();
          getAreas();
          yield AreaListState(areaList: _areasList);
        } catch (e) {}

        break;

      case DeleteRoleEvent:
        _area = await _areaRepo.deleteRole(AreaRole(id: event.areaString));
        yield AreaFormState(area: _area);
        try {} catch (e) {}

        break;

      case SetAreaEvent:
        _area = await _areaRepo.setArea(_area);
        yield Success();
        getAreas();
        yield AreaFormState(area: _area);
        break;

      case UpdateAreaFormEvent:
        yield AreaFormState(area: _area);

        break;
      case UpdateAreaFormByIdEvent:
        if (event is UpdateAreaFormByIdEvent)
          _area = await _areaRepo.getAreaById(event.id);
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
      case UpdateAreaData:
        if (event is UpdateAreaData) {
          _area = await _areaRepo.getAreaByName(event.area.area);
          _areasList = await _areaRepo.getAreas();
          yield AreaFormState(area: _area, areaList: _areasList);
        }
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

  getStepes(String area) {
    if (area == null) return;
    add(GetStepsEvent(Area(area: area)));
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
    add(UpdateAreaFormByIdEvent(id: id));
  }

  setAreaFormByArea(String area) {
    if (area == null) {
      return;
    }

    Area(area: area);
    add(UpdateAreaData(area: Area(area: area)));
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

  void celarSelected() {
    _step = null;
    add(EmitSteptEvent());
  }
}
