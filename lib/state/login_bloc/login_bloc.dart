import 'package:bloc/bloc.dart';
import 'package:bookyourdriveing/models/user.model.dart';
import 'package:bookyourdriveing/services/http/http_login.dart';
import 'package:bookyourdriveing/services/loacal_storage.dart';

import 'package:bookyourdriveing/state/login_bloc/login_event.dart';
import 'package:bookyourdriveing/state/login_bloc/login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  final httpService = HttpLoginService();
  final _localStorageService =  LocalStorageService();
  @override
  LoginState get initialState => LoginState.initial();

  @override
  Stream<LoginState> mapEventToState(LoginEvent event) async* {
    dynamic data;
    yield LoadingState();
    switch (event.runtimeType) {
      case CheckSinginEvent: 
      data = await httpService.isMe();
      print('data after $data');
      if (data == null) {
          yield LoginState(user: null);
      }
      print(data);
      yield LoginState(user:data);
      break;
      case SignInEvent:
        data = await httpService.login(event.user);
         _localStorageService.setToken(data.token);
        yield LoginState(user: data);
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
            _localStorageService.removeToken();
          
        break;
      default:
        yield LoginState(user: null);
    }
  }

  void onLogIn(User user) {
    if(user == null) {
      return;
    }
    add(SignInEvent(user: user));
  }

  void onSignUp(User user) {
     if(user == null) {
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
