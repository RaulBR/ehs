import 'package:bloc/bloc.dart';
import 'package:ehsfocus/models/user.model.dart';
import 'package:ehsfocus/screens/login/login_bloc/login_event.dart';
import 'package:ehsfocus/screens/login/login_bloc/login_state.dart';
import 'package:ehsfocus/services/http/http_login.dart';
import 'package:ehsfocus/services/loacal_storage.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  final httpService = HttpLoginService();
  final _localStorageService = LocalStorageService();
  User _logedInUser = User();
  LoginBloc() : super(LoginInitial()) {
    if (_localStorageService.getToken() != null) {
      amILogendIn();
    }
  }

  @override
  Stream<LoginState> mapEventToState(LoginEvent event) async* {
    dynamic data;
    yield UserLoginError(error: User());
    switch (event.runtimeType) {
      case CheckSinginEvent:
        String token = await _localStorageService.getToken();
        if (token == null) {
          return;
        }
        yield AppLoadingState();
        try {
          data = await httpService.isMe();
          _logedInUser = data;
          await _localStorageService.setRole(data.role);
          await _storeDataLocaly(_logedInUser);
          yield AuthorizedState(user: data);
        } catch (e) {
          yield LoginError(error: 'eroare la login');
          break;
        }

        break;

      case SignInEvent:
        yield LoadingState();
        try {
          data = await httpService.login(event.user);
          _logedInUser = data;
          await _storeDataLocaly(_logedInUser);
          yield AuthorizedState(user: data);
        } catch (e) {
          yield UserFormState(event.user ?? User());
          yield LoginError(error: 'eroare la login');
        }
        break;

      case SignUpEvent:
        try {
          data = await httpService.signUp(event.user);
          // if (data is String) {
          //   yield LoginError(error: data);
          // }

          await _storeDataLocaly(data);
          // yield UserFormState(event.user);
          yield AuthorizedState(user: data);
        } catch (e) {
          yield UserFormState(event.user ?? User());
          yield UserLoginError(error: User.fromJson(e));
          print(e);
        }
        break;

      case SignOutEvent:
        data = await httpService.signOut();
        await _localStorageService.removeToken();
        await _localStorageService.removeRole();
        yield LogoutState();
        break;

      default:
        yield AuthorizedState(user: null);
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

  getUserRole() {
    return _logedInUser.role;
  }

  void onLogout() {
    add(SignOutEvent());
  }

  _storeDataLocaly(data) async {
    await _localStorageService.setToken(data.token);
    await _localStorageService.setRole(data.role);
  }
}
