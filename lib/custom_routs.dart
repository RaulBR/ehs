import 'package:ehsfocus/screens/admin_screen/admin_screen.dart';
import 'package:ehsfocus/screens/aspect_distribution/aspects_to_distribute.dart';
import 'package:ehsfocus/screens/aspect_distribution/aspects_to_fix_list.dart';
import 'package:ehsfocus/screens/category/audit_type.dart';
import 'package:ehsfocus/screens/forms/area/audit_list.dart';
import 'package:ehsfocus/screens/forms/audit/audit_form.dart';
import 'package:ehsfocus/screens/forms/employee/employee_admin.dart';
import 'package:ehsfocus/screens/forms/employee/my_data.dart';
import 'package:ehsfocus/screens/forms/incident_form.dart';
import 'package:ehsfocus/screens/home/home.dart';
import 'package:ehsfocus/screens/login/login.dart';
import 'package:ehsfocus/screens/login/signup_form.dart';
import 'package:ehsfocus/shared/constants.dart';
import 'package:ehsfocus/screens/statitstics/statistics.dart';
import 'package:ehsfocus/services/loacal_storage.dart';
import 'package:ehsfocus/shared/loading.dart';
import 'package:flutter/material.dart';

class CustomRouter {
  final dynamic context;
  CustomRouter({this.context});
  final _localStorageService = LocalStorageService();
  Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case RoutPath.homeRout:
        return checkRoute(Home(), settings);

      case RoutPath.safetyRout:
        return checkRoute(AuditForm(), settings);

      case RoutPath.statsRout:
        return checkRoute(Statistics(), settings);

      case RoutPath.helthRout:
        return checkRoute(AuditForm(), settings);

      case RoutPath.enviromentRout:
        return checkRoute(AuditForm(), settings);

      case RoutPath.incidentRout:
        return checkRoute(IncidentForm(), settings);

      case RoutPath.auditsRoute:
        return checkRoute(AreaMentenance(), settings);

      case RoutPath.employeeRout:
        return checkRoute(EmployeeAdmin(), settings);

      case RoutPath.categoryRoute:
        return checkRoute(CategoryForm(), settings);

      case RoutPath.adminRoute:
        return checkRoute(AdminScreen(), settings);

      case RoutPath.areaRoute:
        return checkRoute(AreaMentenance(), settings);

      case RoutPath.loading:
        return freeRoute(Loading());

      case RoutPath.login:
        return freeRoute(LoginForm());

      case RoutPath.signup:
        return freeRoute(SignUpForm());

      case RoutPath.meRout:
        return checkRoute(MyData(), settings);

      case RoutPath.overwiewAudits:
        return checkRoute(DistributeAspectsLsit(), settings);
      case RoutPath.myResponsibility:
        return checkRoute(AuditsToFixLsit(), settings);
      default:
        return MaterialPageRoute(
            builder: (_) => Scaffold(
                  body: Center(
                      child: Text('No route defined for ${settings.name}')),
                ));
    }
  }

  MaterialPageRoute checkRoute(Widget inputWidget, settings) {
    // BlocProvider.of<LoginBloc>(context).amILogendIn();
    return MaterialPageRoute(
        builder: (_) =>
            _localStorageService.getToken() != null ? inputWidget : LoginForm(),
        settings: settings);
  }

  MaterialPageRoute freeRoute(Widget inputWidget) {
    return MaterialPageRoute(builder: (_) => inputWidget);
  }
}
