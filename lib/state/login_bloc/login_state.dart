import 'package:bookyourdriveing/models/user.model.dart';

class LoginState {
  User user;
  LoginState({this.user});
  factory LoginState.initial() => LoginState(user: null);
}

class LoadingState extends LoginState {
  bool isLoading = false;
  LoadingState() {
    isLoading = !isLoading;
  }
}

class LoginError extends LoginState {
  String error;

  LoginError({this.error});
  factory LoginError.initial() => LoginError(error: null);
}
