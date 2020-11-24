import 'package:ehsfocus/screens/category/category_service.dart';
import 'package:ehsfocus/shared/fields/search_picker/custom_list_search.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'bloc/category_bloc.dart';

class CategoryPiker extends StatelessWidget {
  final bool isEditable;
  final String label;
  final String input;
  final Function hasChanges;
  const CategoryPiker(
      {Key key, this.isEditable, this.label, this.input, this.hasChanges})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    String _input = input;
    return BlocListener<CategoryBloc, CategoryState>(
      listener: (context, state) {
        if (state is OneCategoryState) {
          _input = (state.categorie?.category);
        }
      },
      child: BlocBuilder<CategoryBloc, CategoryState>(
        buildWhen: (previous, current) =>
            current is CategorysState || current is OneCategoryState,
        builder: (context, state) => EhsSearchListPicker(
          isEditable: isEditable,
          list: CategorySertvice().handleCategorysStateChange(context, state),
          label: label,
          tapped: () {
            BlocProvider.of<CategoryBloc>(context).add(GetCategorysEvent());
          },
          selected: (value2) {
            BlocProvider.of<CategoryBloc>(context).selectCategory(value2.id);
            hasChanges(value2.title);
          },
          preselected: _input,
        ),
      ),
    );
  }
}
