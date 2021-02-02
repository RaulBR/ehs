import 'package:ehsfocus/errors/category_exception.dart';
import 'package:ehsfocus/models/category/category_model.dart';
import 'package:ehsfocus/models/category/category_type_model.dart';

import 'package:ehsfocus/services/repository/local_database/repo.dart';
import 'package:ehsfocus/shared/constants.dart';
import 'package:hive/hive.dart';

class CategoryLocalDb extends HiveRepo {
  Future<List<CategoryType>> getCategoryTypes() async {
    try {
      Box<CategoryType> categorytypeBox =
          await initiateBox(HiveName.categoryType);
      if (categorytypeBox.length > 0) {
        return convertBoxToList<CategoryType>(categorytypeBox);
      }
      return [];
    } catch (e) {
      throw CategoryTypeException('retriveError');
    }
  }

  setCategoryType({CategoryType categoryType}) async {
    try {
      Box<CategoryType> categorytypeBox =
          await initiateBox(HiveName.categoryType);
      String id = categoryType.id;
      await categorytypeBox.put(id, categoryType);
    } catch (e) {
      throw CategoryTypeException('save error');
    }
  }

  Future<AuditCategory> getCategoryTypeById(
      CategoryType categoryType, String id) async {
    if (id == null) return null;
    Box<CategoryType> categorytypeBox =
        await initiateBox(HiveName.categoryType);
    CategoryType categoryDto = categorytypeBox.get(categoryType.id);
    return categoryDto.categories
        .firstWhere((element) => element.id == id, orElse: () => null);
  }

  getCategoryById(String id) async {
    if (id == null) return;
    Box<CategoryType> categorytypeBox =
        await initiateBox(HiveName.categoryType);
    return categorytypeBox.get(id);
  }

  deleteCategoryTypes(CategoryType categoryType) async {
    Box<CategoryType> categorytypeBox =
        await initiateBox(HiveName.categoryType);
    try {
      String id = categoryType.id;
      categorytypeBox.delete(id).then((value) {}).catchError((value) {
        print('error');
      });
    } catch (e) {
      throw CategoryTypeException('delete error');
    }
  }

  Future<void> clearBox() async {
    Box<CategoryType> categorytypeBox =
        await initiateBox(HiveName.categoryType);
    categorytypeBox.clear();
  }

  Future<void> saveCategoryTypesToLocalDb(
      List<CategoryType> categorytype) async {
    Box<CategoryType> categorytypeBox =
        await initiateBox(HiveName.categoryType);
    if (categorytype.length > 0) {
      categorytype.forEach((element) {
        categorytypeBox.put(element.id, element);
      });
    }
  }
}
