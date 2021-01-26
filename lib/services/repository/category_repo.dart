import 'package:ehsfocus/errors/category_exception.dart';
import 'package:ehsfocus/models/category/category_model.dart';
import 'package:ehsfocus/models/category/category_type_model.dart';
import 'package:ehsfocus/services/http/http_category.dart';
import 'package:ehsfocus/services/repository/local_database/category_local_db.dart';

class CategoryRepo {
  HttpCategoryService _httpCategoryService = HttpCategoryService();
  CategoryLocalDb _categoryLocalDb = CategoryLocalDb();
  Future<List<CategoryType>> getCategoryTypes() async {
    try {
      List<CategoryType> categorytype =
          await _categoryLocalDb.getCategoryTypes();
      if (categorytype.length > 0) return categorytype;
      categorytype = await _httpCategoryService.getCategoryTypes();
      await _categoryLocalDb.saveCategoryTypesToLocalDb(categorytype);
      return categorytype;
    } catch (e) {
      throw CategoryTypeException('retriveError');
    }
  }

  setCategoryType({CategoryType categoryType}) async {
    try {
      CategoryType categorytypeDto = await _httpCategoryService.setCategoryType(
          categoryType: categoryType);
      await _categoryLocalDb.setCategoryType(categoryType: categorytypeDto);
    } catch (e) {
      throw CategoryTypeException('save error');
    }
  }

  Future<AuditCategory> getCategoryTypeById(
      CategoryType categoryType, String id) async {
    if (id == null) return null;
    return _categoryLocalDb.getCategoryTypeById(categoryType, id);
  }

  getCategoryById(String id) async {
    if (id == null) return;
    return await _categoryLocalDb.getCategoryById(id);
  }

  deleteCategoryTypes({CategoryType categoryType}) async {
    try {
      await _httpCategoryService.deleteCategoryTypes(
          categoryType: categoryType);

      await _categoryLocalDb.deleteCategoryTypes(categoryType);
    } catch (e) {
      throw CategoryTypeException('delete error');
    }
  }

  Future<void> clearLocalDb() async {
    await _categoryLocalDb.clearBox();
  }
}
