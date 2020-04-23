class LoginState {
  bool isLogin = false;

  LoginState({this.isLogin});

  factory LoginState.initial() => LoginState(isLogin: false);
}
