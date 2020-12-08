import 'package:ehsfocus/models/user.model.dart';

abstract class LoginEvent {
  User user;
}

class SignInEvent extends LoginEvent {
  User user;
  SignInEvent({this.user});
}

class SignUpEvent extends LoginEvent {}

class SigninLoading extends LoginEvent {}

class CheckSinginEvent extends LoginEvent {}

class Loding extends LoginEvent {}

class SignOutEvent extends LoginEvent {}
