import 'package:ehsfocus/bloc/category/category_bloc.dart';
import 'package:ehsfocus/screens/category/category_picker.dart';
import 'package:ehsfocus/screens/category/category_type_picker.dart';
import 'package:ehsfocus/shared/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CategoryGroupPicker extends StatelessWidget {
  final CategoryError error;
  final bool isEditable;
  final String categoryType;
  final String category;
  final Function getCategory;
  final Function getCategoryType;
  const CategoryGroupPicker(
      {Key key,
      this.isEditable,
      this.categoryType,
      this.category,
      this.error,
      this.getCategory,
      this.getCategoryType})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return BlocProvider<CategoryBloc>(
      create: (context) => CategoryBloc(),
      child: Column(
        children: [
          CategoryTypePiker(
            error: error == null ? null : error.categoryType,
            input: categoryType,
            isEditable: isEditable,
            hasChanges: (_categoryType) => getCategoryType(_categoryType),
            label: Labels.aspectType,
          ),
          CategoryPiker(
            error: error == null ? null : error.category,
            input: category,
            isEditable: isEditable,
            hasChanges: (_category) => getCategory(_category),
          ),
        ],
      ),
    );
  }
}

class CategoryError {
  final String category;
  final String categoryType;
  CategoryError({this.categoryType, this.category});
}
