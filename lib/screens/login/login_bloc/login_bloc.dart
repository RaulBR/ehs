import 'package:bloc/bloc.dart';
import 'package:ehsfocus/models/user.model.dart';
import 'package:ehsfocus/screens/login/login_bloc/login_event.dart';
import 'package:ehsfocus/screens/login/login_bloc/login_state.dart';
import 'package:ehsfocus/services/http/http_login.dart';
import 'package:ehsfocus/services/loacal_storage.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  final httpService = HttpLoginService();
  final _localStorageService = LocalStorageService();
  final localStorageService = LocalStorageService();
  LoginBloc() : super(LoginState.initial()) {
    if (localStorageService.getToken() != null) {
      amILogendIn();
    }
  }

  @override
  Stream<LoginState> mapEventToState(LoginEvent event) async* {
    dynamic data;
    switch (event.runtimeType) {
      case CheckSinginEvent:
        yield AppLoadingState();
        try {
          data = await httpService.isMe();
          yield LoginState(user: data);
        } catch (e) {
          yield LoginError(error: 'eroare la login');
          break;
        }

        break;

      case SignInEvent:
        yield LoadingState();
        try {
          data = await httpService.login(event.user);
          await _localStorageService.setToken(data.token);
          yield LoginState(user: data);
        } catch (e) {
          yield LoginError(error: 'eroare la login');
        }
        break;

      case SignUpEvent:
        try {
          data = await httpService.signUp(event.user);
          if (data is String) {
            yield LoginError(error: data);
          }
          _localStorageService.setToken(data.token);
          yield LoginState(user: data);
        } catch (e) {}
        break;

      case SignOutEvent:
        data = await httpService.signOut();
        await _localStorageService.removeToken();
        yield LogoutState();
        break;

      default:
        yield LoginState(user: null);
    }
  }

  void onLogIn(User user) {
    // if (user == null) {
    //   return;
    // }
    add(SignInEvent(user: user));
  }

  void onSignUp(User user) {
    if (user == null) {
      return;
    }
    add(SignUpEvent(user: user));
  }

  void amILogendIn() {
    add(CheckSinginEvent());
  }

  void onLogout() {
    add(SignOutEvent());
  }
}
