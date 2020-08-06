import 'package:ehsfocus/models/category_model.dart';
import 'package:ehsfocus/screens/category/bloc/category_bloc.dart';
import 'package:ehsfocus/screens/category/category_type.dart';
import 'package:ehsfocus/screens/category/category_type_list.dart';
import 'package:ehsfocus/shared/constants.dart';
import 'package:ehsfocus/shared/form_eleements/generic_list_page_search.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CategoryForm extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    List<CategoryType> _categoryesType = [];
    return BlocProvider<CategoryBloc>(
      create: (context) => CategoryBloc(),
      child: SearchPageWrapper(
        title: Labels.aspectType,
        search: (data) {
          print(data);
        },
        child: BlocBuilder<CategoryBloc, CategoryState>(
          builder: (context, state) {
            if (state is CategorysTypesState) {
              print(state.categoryes);
              _categoryesType = state.categoryes;
            }
            return EhsCategoryTypeList(
              categoryTypes: _categoryesType,
              selected: (data) {
                // navigate
              },
            );
          },
        ),
        addForm: CategoryTypeMentenanceForm(),
      ),
    );
  }
}
