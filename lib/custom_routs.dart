
import 'package:bookyourdriveing/screens/home/home_screen.dart';
import 'package:bookyourdriveing/screens/login/login.dart';
import 'package:bookyourdriveing/shared/loading.dart';
import 'package:flutter/material.dart';


class Router {
  // LoginBloc _authGuard;
  // Router(LoginBloc loginBloc) {
  //   this._authGuard = loginBloc;
  // } 
  bool isAllowed = true;
  Route<dynamic> generateRoute(RouteSettings settings) {
      
    switch (settings.name) {
       case '/':
         return  freeRoute(Home());
         break;        
      case '/loading':
        return freeRoute(Loading2());
         break;
      default:
        return MaterialPageRoute(
            builder: (_) => Scaffold(
                  body: Center(
                      child: Text('No route defined for ${settings.name}')),
                ));
    }
  }
  MaterialPageRoute checkRoute(Widget inputWidget) {
    return  MaterialPageRoute(builder: (_) =>  isAllowed ? inputWidget : LoginForm());
  }
  MaterialPageRoute freeRoute(Widget inputWidget) {
    return  MaterialPageRoute(builder: (_) =>  inputWidget );
  }

// bool getAuth() {
//   print('i was here dawdasd asd ${_authGuard.state.isLogin}');
//   return _authGuard.state.isLogin;
// }
}
