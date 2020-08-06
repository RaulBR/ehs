import 'package:ehsfocus/models/drop_down_model.dart';
import 'package:ehsfocus/screens/category/bloc/category_bloc.dart';

import 'package:ehsfocus/screens/forms/audit/audit_bloc/audit_bloc_index.dart';

class AspectService {
  List<DropDown> handleCategorysStateChange(context, state) {
    if (state is CategorysTypesState) {
      return state.categoryes
          .map((d) => DropDown(id: d.id, type: d.type))
          .toList();
    }
    if (state is CategorysState) {
      return state.categoryes
          .map((e) => DropDown(id: e.id, type: e.category))
          .toList();
    }
  }

  List<DropDown> handleResponsableForAspect(context, state) {
    if (state is AutidResponsable) {
      return [DropDown(id: '1', type: '123123')];
    }
  }
}
