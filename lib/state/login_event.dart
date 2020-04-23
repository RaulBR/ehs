import 'package:bookyourdriveing/models/user.model.dart';

abstract class LoginEvent {
  User user;
}

class SignInEvent extends LoginEvent {
  User user;
  SignInEvent({this.user});
}
class SignUpEvent extends LoginEvent {
    User user;
  SignUpEvent({this.user});
}

class SigninLoading extends LoginEvent {
}

class SignOutEvent extends LoginEvent {}
