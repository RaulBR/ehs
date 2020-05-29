import 'package:ehsfocus/models/aspects_model.dart';

class AspectsState {
  List<Aspect> aspects;
  AspectsState({this.aspects});
  factory AspectsState.initial() => AspectsState(aspects: []);
}

class AspectsLoadingState extends AspectsState {}

class AspectsError extends AspectsState {
  String error;

  AspectsError({this.error});
  factory AspectsError.initial() => AspectsError(error: null);
}
