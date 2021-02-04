import 'package:ehsfocus/app_localizations.dart';
import 'package:ehsfocus/bloc/area/area_bloc.dart';
import 'package:ehsfocus/custom_routs.dart';
import 'package:ehsfocus/bloc/category/category_bloc.dart';
import 'package:ehsfocus/bloc/audit_bloc/audit_bloc.dart';
import 'package:ehsfocus/bloc/employee/employee_bloc.dart';
import 'package:ehsfocus/services/websocket_service.dart/audit_socket_bloc/audit_socket_bloc.dart';
import 'package:ehsfocus/shared/constants.dart';
import 'package:ehsfocus/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

class MainApp extends StatefulWidget {
  @override
  _MainAppState createState() => _MainAppState();
}

class _MainAppState extends State<MainApp> {
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<EmployeeBloc>(
          create: (contect) => EmployeeBloc(),
        ),
        BlocProvider<AuditSocketBloc>(
          create: (contect) => AuditSocketBloc(),
        ),
        BlocProvider(
          create: (_) => AuditBloc(),
        ),
        BlocProvider(
          create: (_) => CategoryBloc(),
        ),
        BlocProvider<AreaBloc>(
          create: (_) => AreaBloc(),
        ),
      ],
      child: MaterialApp(
        title: Labels.ehsTitle,
        theme: companyThemeData,
        supportedLocales: [Locale('ro', 'RO'), Locale('en', 'US')],
        localizationsDelegates: [
          AppLocalizations.delegate,
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate
        ],
        localeResolutionCallback: (locale, supportedLocales) {
          for (var supportedLocale in supportedLocales) {
            if (locale == null) {
              return supportedLocales.first;
            }
            if (supportedLocale.languageCode == locale.languageCode &&
                supportedLocale.countryCode == locale.countryCode) {
              return supportedLocale;
            }
          }
          return supportedLocales.first;
        },
        onGenerateRoute: CustomRouter(context: context).generateRoute,
        initialRoute: '/',
      ),
    );
  }

  @override
  void dispose() {
    BlocProvider.of<AuditSocketBloc>(context).disconnect();
    super.dispose();
  }
}
