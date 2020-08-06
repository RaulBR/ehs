part of 'area_bloc.dart';

@immutable
abstract class AreaState {}

class AreaInitial extends AreaState {
  final List<Area> areaList;
  final AuditHead area;
  AreaInitial({
    this.areaList,
    this.area,
  });
  factory AreaInitial.initial() => AreaInitial(areaList: null);
}

class AreaListState extends AreaState {
  final List<Area> areaList;
  AreaListState({this.areaList});
}

class StepListState extends AreaState {
  final List<String> stepList;
  StepListState({this.stepList});
}

class AreaValueState extends AreaState {
  final AuditHead area;
  AreaValueState({this.area});
}

class AreaFormState extends AreaState {
  final Area area;
  AreaFormState({this.area});
}

class ClearStep extends AreaState {}
