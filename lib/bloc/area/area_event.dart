part of 'area_bloc.dart';

abstract class AreaEvent {
  Area area;
  String areaString;
  AuditHead areaValue;
  AreaRole areaRole;
}

class GetAreasEvent extends AreaEvent {}

class GetStepsEvent extends AreaEvent {
  final Area area;

  GetStepsEvent(this.area);
}

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

class UpdateAreaData extends AreaEvent {
  final Area area;
  final List<Area> areas;
  UpdateAreaData({this.area, this.areas});
}

class UpdateAreaFormEvent extends AreaEvent {
  final Area area;
  UpdateAreaFormEvent({this.area});
}

// class AddVisibilittyEvent extends AreaEvent {
//   final bool isAddVisible;
//   AddVisibilittyEvent({this.isAddVisible});
// }

class UpdateAreaFormByIdEvent extends AreaEvent {
  final String id;
  UpdateAreaFormByIdEvent({this.id});
}

class SetRoleEvent extends AreaEvent {
  final AreaRole areaRole;
  SetRoleEvent(this.areaRole);
}

class SearchAreas extends AreaEvent {
  final String areaString;
  SearchAreas(this.areaString);
}

class EmitSteptsEvent extends AreaEvent {}

class EmitSteptEvent extends AreaEvent {}

class DeleteSteptEvent extends AreaEvent {}

class SearchStepts extends AreaEvent {
  final String areaString;
  SearchStepts(this.areaString);
}
