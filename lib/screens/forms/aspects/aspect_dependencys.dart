import 'package:ehsfocus/screens/category/bloc/category_bloc.dart';
import 'package:ehsfocus/screens/forms/area/bloc/area_bloc.dart';
import 'package:ehsfocus/screens/forms/aspects/bloc/aspect_bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/material.dart';

class AspectBlocDependencyes extends StatelessWidget {
  final Widget child;

  const AspectBlocDependencyes({Key key, this.child}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(providers: [
      // BlocProvider<AspectBloc>(
      //   create: (_) => AspectBloc(),
      // ),
      BlocProvider<AreaBloc>(
        create: (_) => AreaBloc(),
      ),
      // BlocProvider<CategoryBloc>(
      //   create: (_) => CategoryBloc(),
      // ),
    ], child: child);
  }
}
