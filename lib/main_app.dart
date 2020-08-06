import 'package:ehsfocus/app_localizations.dart';
import 'package:ehsfocus/custom_routs.dart';
import 'package:ehsfocus/screens/forms/audit/audit_bloc/audit_bloc.dart';
import 'package:ehsfocus/screens/forms/employee/bloc/employee_bloc.dart';
import 'package:ehsfocus/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

class MainApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<EmployeeBloc>(
          create: (contect) => EmployeeBloc(),
        ),
        BlocProvider(
          create: (_) => AuditBloc(),
        ),
      ],
      child: MaterialApp(
        title: 'EHS-focus',
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
        onGenerateRoute: Router().generateRoute,
        initialRoute: '/',
      ),
    );
  }
}
