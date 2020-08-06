import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:ehsfocus/models/area_modal.dart';
import 'package:ehsfocus/models/audit_head_modal.dart';
import 'package:ehsfocus/models/request_models.dart';
import 'package:ehsfocus/services/http/http_area.dart';
import 'package:flutter/cupertino.dart';
import 'package:meta/meta.dart';

part 'area_event.dart';
part 'area_state.dart';

class AreaBloc extends Bloc<AreaEvent, AreaState> {
  AuditHead areaHead = AuditHead();
  Area _area = Area();
  PaginationObject _requestParams = PaginationObject();
  HttpAreaService httpAreaService = HttpAreaService();
  List<String> a = [];
  List<dynamic> _data = [];
  Map<String, List<String>> areas = {};

  AreaBloc(this.areaHead) : super(AreaInitial.initial()) {
    //  getAreas();
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
        _data = ucelessLanguageList
            .map((ucelenssLamngauageListElement) => Area(
                id: ucelenssLamngauageListElement.id,
                area: ucelenssLamngauageListElement.area,
                areaInfo: ucelenssLamngauageListElement.areaInfo))
            .toList();

        yield AreaListState(areaList: _data ?? []);
        break;
      case SearchAreas:
        if (event.area == '') {
          yield AreaListState(areaList: _data);
          break;
        }
        List<Area> b = [];
        _data.forEach((element) {
          if (element.area.contains(event.area)) {
            b.add(element);
          }
        });

        yield AreaListState(areaList: b);
        break;
      case GetStepsEvent:
        yield StepListState(stepList: areas['1']);

        break;
      case UpdateAreaEvent:
        yield AreaValueState(area: event.areaValue);

        break;
      case SetRoleEvent:
        print(event.areaRole);
        if (_area.roles == null) {
          _area.roles = [];
        }
        _area.roles.add(event.areaRole);
        yield AreaFormState(area: _area);

        break;
      default:
      // yield AreaListState(areaList: _data ?? []);
    }
  }

  getAreas() {
    add(GetAreasEvent());
  }

  getStepes() {
    add(GetStepsEvent());
  }

  setArea(AuditHead area) {
    areaHead = area;
    add(UpdateAreaEvent(areaValue: area));
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
}
