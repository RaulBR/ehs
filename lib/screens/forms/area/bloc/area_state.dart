part of 'area_bloc.dart';

@immutable
abstract class AreaState {
  final Area area;
  AreaState({
    this.area,
  });
}

class AreaInitial extends AreaState {
  final List<Area> areaList;
  AreaInitial({
    this.areaList,
  });
  factory AreaInitial.initial() => AreaInitial(areaList: null);
}

class Error extends AreaState {}

class Success extends AreaState {}

class AreaListState extends AreaState {
  final List<Area> areaList;
  AreaListState({this.areaList});
}

class StepListState extends AreaState {
  final List<String> stepList;
  StepListState({this.stepList});
}

class AreaFormState extends AreaState {
  final Area area;
  AreaFormState({this.area});
}

class ClearStep extends AreaState {}
