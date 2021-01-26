import 'package:ehsfocus/bloc/category/category_bloc.dart';
import 'package:ehsfocus/bloc/category/category_state.dart';
import 'package:ehsfocus/models/category/category_type_model.dart';
import 'package:ehsfocus/screens/category/category_service.dart';
import 'package:ehsfocus/shared/fields/search_picker/custom_list_search.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CategoryTypePiker extends StatelessWidget {
  final String error;
  final bool isEditable;
  final String label;
  final String input;
  final Function hasChanges;
  const CategoryTypePiker(
      {Key key,
      this.isEditable,
      this.label,
      this.input,
      this.hasChanges,
      this.error})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    String _input = input;
    return BlocBuilder<CategoryBloc, CategoryState>(
      buildWhen: (previous, current) =>
          current is CategorysTypesState ||
          current is OneCategoryTypesState, //CategoryTypeChangedState,
      builder: (context, state) {
        if (state is OneCategoryTypesState) {
          _input = (state.categorie.type);
        }
        return EhsSearchListPicker(
          isEditable: isEditable,
          error: error,
          list: CategorySertvice().handleCategorysStateChange(context, state),
          label: label,
          tapped: () =>
              BlocProvider.of<CategoryBloc>(context).addGetCategoryTypeEvent(),
          selected: (value2) {
            BlocProvider.of<CategoryBloc>(context).selectedType(value2.id);
            hasChanges(value2.title);
          },
          preselected: _input,
        );
      },
    );
  }
}

class CategoryTypeObjectPiker extends StatelessWidget {
  final String error;
  final bool isEditable;
  final String label;
  final String input;
  final Function hasChanges;
  const CategoryTypeObjectPiker(
      {Key key,
      this.isEditable,
      this.label,
      this.input,
      this.hasChanges,
      this.error})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    String _input = input;
    return BlocListener<CategoryBloc, CategoryState>(
      listener: (context, state) {
        if (state is OneCategoryTypesState) {
          _input = (state.categorie.type);
        }
      },
      child: BlocBuilder<CategoryBloc, CategoryState>(
        buildWhen: (previous, current) =>
            current is CategorysTypesState ||
            current is OneCategoryTypesState, //CategoryTypeChangedState,
        builder: (context, state) => EhsSearchListPicker(
          isEditable: isEditable,
          error: error,
          // change with provider.
          list: CategorySertvice().handleCategorysStateChange(context, state),
          label: label,
          tapped: () =>
              BlocProvider.of<CategoryBloc>(context).addGetCategoryTypeEvent(),
          selected: (value2) {
            CategoryType categoryType = BlocProvider.of<CategoryBloc>(context)
                .getCategoryformId(value2.id);
            hasChanges(categoryType);
          },
          preselected: _input,
        ),
      ),
    );
  }
}
