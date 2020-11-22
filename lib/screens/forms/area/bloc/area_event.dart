part of 'area_bloc.dart';

abstract class AreaEvent {
  String areaString;
  AuditHead areaValue;
  AreaRole areaRole;
}

class GetAreasEvent extends AreaEvent {}

class GetStepsEvent extends AreaEvent {}

class DeleteAreasEvent extends AreaEvent {
  final String areaString;

  DeleteAreasEvent(this.areaString);
}

class SetAreaEvent extends AreaEvent {
  final Area area;

  SetAreaEvent({this.area});
}

class DeleteRoleEvent extends AreaEvent {
  final String areaString;

  DeleteRoleEvent(this.areaString);
}

class DeleteAreaEvent extends AreaEvent {
  final String areaString;

  DeleteAreaEvent(this.areaString);
}

class UpdateAreaEvent extends AreaEvent {
  final AuditHead areaValue;

  UpdateAreaEvent({this.areaValue});
}

class UpdateAreaFormEvent extends AreaEvent {
  final Area area;
  UpdateAreaFormEvent({this.area});
}

class SetRoleEvent extends AreaEvent {
  final AreaRole areaRole;
  SetRoleEvent(this.areaRole);
}

class SearchAreas extends AreaEvent {
  final String areaString;
  SearchAreas(this.areaString);
}

// class SetSelectedArea extends AreaEvent {
//   final Area areaValue;
//   SetSelectedArea({
//     this.areaValue,
//   });
// }

class SearchStepts extends AreaEvent {
  final String areaString;
  SearchStepts(this.areaString);
}
