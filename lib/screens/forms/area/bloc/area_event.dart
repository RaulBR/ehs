part of 'area_bloc.dart';

abstract class AreaEvent {
  String area;
  AuditHead areaValue;
  AreaRole areaRole;
}

class GetAreasEvent extends AreaEvent {}

class GetStepsEvent extends AreaEvent {}

class SetAreasEvent extends AreaEvent {}

class DeleteAreaEvent extends AreaEvent {}

class UpdateAreaEvent extends AreaEvent {
  final AuditHead areaValue;

  UpdateAreaEvent({this.areaValue});
}

class SetRoleEvent extends AreaEvent {
  final AreaRole areaRole;
  SetRoleEvent(this.areaRole);
}

class SearchAreas extends AreaEvent {
  final String area;
  SearchAreas(this.area);
}

// class SetSelectedArea extends AreaEvent {
//   final Area areaValue;
//   SetSelectedArea({
//     this.areaValue,
//   });
// }

class SearchStepts extends AreaEvent {
  final String area;
  SearchStepts(this.area);
}
