import 'package:ehsfocus/models/user.model.dart';

abstract class LoginState {
  User user;
  // factory LoginState.initial() => LoginState(user: null);
}

class LoginInitial extends LoginState {}

class AuthorizedState extends LoginState {
  final User user;

  AuthorizedState({this.user});
}

class LoadingState extends LoginState {
  bool isLoading = false;
  LoadingState() {
    isLoading = !isLoading;
  }
}

class UserFormState extends LoginState {
  final User user;

  UserFormState(this.user);
}

class AppLoadingState extends LoginState {
  AppLoadingState();
}

class LogoutState extends LoginState {}

class LoginError extends LoginState {
  String error;

  LoginError({this.error});
}

class UserLoginError extends LoginState {
  User error;

  UserLoginError({this.error});
}
