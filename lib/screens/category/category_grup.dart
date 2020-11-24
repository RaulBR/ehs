import 'package:ehsfocus/screens/category/bloc/category_bloc.dart';
import 'package:ehsfocus/screens/category/category_picker.dart';
import 'package:ehsfocus/screens/category/category_type_picker.dart';
import 'package:ehsfocus/shared/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

// TODO not used
class CategoryGroup extends StatelessWidget {
  final bool isEditable;
  final String categoryType;
  final String category;
  final Function hasChanges;
  const CategoryGroup(
      {Key key,
      this.isEditable,
      this.categoryType,
      this.hasChanges,
      this.category})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    String _category;
    String _categoryType;
    return BlocProvider<CategoryBloc>(
      create: (context) => CategoryBloc(),
      child: Column(
        children: [
          CategoryTypePiker(
            input: categoryType,
            isEditable: isEditable,
            hasChanges: (value2) {
              _category = value2;
              // hasChanges(_category, _categoryType);
            },
            label: Labels.aspectType,
          ),
          CategoryPiker(
            input: category,
            isEditable: isEditable,
            hasChanges: (value2) {
              _categoryType = value2;
              //  hasChanges(_category, _categoryType);
            },
            label: Labels.category,
          ),
        ],
      ),
    );
  }
}
