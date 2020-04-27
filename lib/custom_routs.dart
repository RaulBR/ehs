import 'package:bookyourdriveing/screens/employee/employee_form.dart';
import 'package:bookyourdriveing/screens/home/home_screen.dart';
import 'package:bookyourdriveing/screens/login/login.dart';
import 'package:bookyourdriveing/services/loacal_storage.dart';
import 'package:bookyourdriveing/shared/loading.dart';
import 'package:flutter/material.dart';

class Router {
  final _localStorageService = LocalStorageService();
  String _token;
  bool isAllowed = true;
  Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case '/':
        return checkRoute(Home());
        break;
      case '/loading':
        return checkRoute(Loading2());
        break;
      case '/employee':
        return checkRoute(EmployeeForm());
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
    return MaterialPageRoute(
        builder: (_) => _localStorageService.getToken() != null
            ? inputWidget
            : LoginForm());
  }

  MaterialPageRoute freeRoute(Widget inputWidget) {
    return MaterialPageRoute(builder: (_) => inputWidget);
  }

// bool getAuth() {
//   print('i was here dawdasd asd ${_authGuard.state.isLogin}');
//   return _authGuard.state.isLogin;
// }
}
