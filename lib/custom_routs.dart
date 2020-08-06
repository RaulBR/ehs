import 'package:ehsfocus/screens/category/audit_type.dart';
import 'package:ehsfocus/screens/forms/area/audit_list.dart';
import 'package:ehsfocus/screens/forms/audit/audit_form.dart';
import 'package:ehsfocus/screens/forms/employee/employee_form.dart';
import 'package:ehsfocus/screens/forms/incident_form.dart';
import 'package:ehsfocus/screens/home/home.dart';
import 'package:ehsfocus/screens/login/login.dart';
import 'package:ehsfocus/shared/constants.dart';
import 'package:ehsfocus/screens/statitstics/statistics.dart';
import 'package:ehsfocus/services/loacal_storage.dart';
import 'package:ehsfocus/shared/loading.dart';
import 'package:flutter/material.dart';

class Router {
  final _localStorageService = LocalStorageService();
  Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case RoutPath.homeRout:
        return checkRoute(Home(), settings);

      case RoutPath.loadingRout:
        return checkRoute(Loading2(), settings);

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
        return checkRoute(AuditList(), settings);

      case RoutPath.employeeRout:
        return checkRoute(EmployeeForm(), settings);

      case RoutPath.categoryRoute:
        return checkRoute(CategoryForm(), settings);

      default:
        return MaterialPageRoute(
            builder: (_) => Scaffold(
                  body: Center(
                      child: Text('No route defined for ${settings.name}')),
                ));
    }
  }

  MaterialPageRoute checkRoute(Widget inputWidget, settings) {
    return MaterialPageRoute(
        builder: (_) =>
            _localStorageService.getToken() != null ? inputWidget : LoginForm(),
        settings: settings);
  }

  MaterialPageRoute freeRoute(Widget inputWidget) {
    return MaterialPageRoute(builder: (_) => inputWidget);
  }
}
