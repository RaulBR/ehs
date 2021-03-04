import 'package:ehsfocus/models/category/category_type_model.dart';
import 'package:ehsfocus/models/employee/employee_model.dart';
import 'package:equatable/equatable.dart';

// ignore: must_be_immutable
class CategoryTypeResponsible extends Equatable {
  String id;
  CategoryType categoryType;
  Employee responsible;

  CategoryTypeResponsible({
    this.id,
    this.responsible,
  });
  Map<String, dynamic> toJson() => {
        "id": id,
        "responsible": responsible?.toJson(),
        "categoryType": categoryType?.toJson(),
      };

  CategoryTypeResponsible.fromJson(Map<String, dynamic> parsedJson) {
    if (parsedJson == null) {
      return;
    }

    id = parsedJson['id'];

    responsible = parsedJson['responsible'] != null
        ? Employee.fromJson(parsedJson['responsible'])
        : null;
    categoryType = CategoryType.fromJson(parsedJson['categoryType']);
  }

  @override
  List<Object> get props => [id, responsible, categoryType];
}
