import 'package:ehsfocus/bloc/category/category_bloc.dart';
import 'package:ehsfocus/bloc/area/area_bloc.dart';
import 'package:ehsfocus/shared/form_eleements/generic_list__search_page/bloc/ehs_generic_list_bloc.dart';

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
        BlocProvider<EhsGenericListBloc>(
          create: (_) => EhsGenericListBloc(),
        ),
      ],
      child: child,
      // ),
    );
  }
}
