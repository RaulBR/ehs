import 'package:ehsfocus/models/user.model.dart';

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
class AppLoadingState extends LoginState {

  AppLoadingState();
    
}
class LogoutState extends LoginState {

}
class LoginError extends LoginState {
  String error;

  LoginError({this.error});
  factory LoginError.initial() => LoginError(error: null);
}
