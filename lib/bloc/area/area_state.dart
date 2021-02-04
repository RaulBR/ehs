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
  final List<AreaStep> stepList;
  StepListState({this.stepList});
}

class AreaFormState extends AreaState {
  final Area area;
  final List<Area> areaList;
  AreaFormState({this.area, this.areaList});
}

class IsAddVisible extends AreaState {
  final bool isAddVisible;
  IsAddVisible({this.isAddVisible});
}

class SelectedStepState extends AreaState {
  final String step;
  SelectedStepState({this.step});
}

class ClearStep extends AreaState {}
