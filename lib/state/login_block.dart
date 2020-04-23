import 'package:bloc/bloc.dart';
import 'package:bookyourdriveing/models/user.model.dart';
import 'package:bookyourdriveing/services/http.dart';
import 'package:bookyourdriveing/state/login_event.dart';
import 'package:bookyourdriveing/state/login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  final httpService = HttpService();

  @override
  // TODO: implement initialState
  LoginState get initialState => LoginState.initial();

  @override
  Stream<LoginState> mapEventToState(LoginEvent event) async* {
 
    switch (event.runtimeType) {
      case SignInEvent:
      yield LoginState(isLogin: true);
        dynamic data =  await httpService.login(event.user);
        if(data is User) {
            yield LoginState(isLogin: true);
        }
        break;
      case SignUpEvent:
        httpService.signUp(event.user).then((value) => print(value));
        break;
      default:
        print('state: fasle');
        yield LoginState(isLogin: false);
    }
  }

  void onLogIn(User user) {
    add(SignInEvent(user: user));
  }

  void onSignUp(User user) {
    add(SignUpEvent(user: user));
  }

  void onLogout() {
    add(SignOutEvent());
  }
}
