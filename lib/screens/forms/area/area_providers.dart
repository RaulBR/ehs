import 'package:ehsfocus/screens/category/bloc/category_bloc.dart';
import 'package:ehsfocus/screens/forms/area/area_service.dart';
import 'package:ehsfocus/screens/forms/area/bloc/area_bloc.dart';
import 'package:ehsfocus/screens/forms/employee/bloc/employee_bloc.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AreaDependencies extends StatelessWidget {
  final Widget child;

  const AreaDependencies({Key key, this.child}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<AreaBloc>(
          create: (_) => AreaBloc(),
        ),
        BlocProvider<CategoryBloc>(
          create: (_) => CategoryBloc(),
        ),
      ],
      child: child,
      // ),
    );
  }
}

class AreaMentenanceFormLiseners extends StatelessWidget {
  final Widget child;
  final Function getData;

  const AreaMentenanceFormLiseners({Key key, this.child, this.getData})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    AreaService areaService = AreaService();
    return MultiBlocListener(
      listeners: [
        BlocListener<EmployeeBloc, EmployeeState>(
          listenWhen: (previous, current) => current is EmployeesValueState,
          listener: (BuildContext context, EmployeeState state) =>
              areaService.addEmployeesToDropDown(context, state),
        )
      ],
      child: child,
    );
  }
}
