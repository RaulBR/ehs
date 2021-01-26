import 'package:ehsfocus/models/category/category_model.dart';
import 'package:ehsfocus/models/employee/employee_model.dart';
import 'package:equatable/equatable.dart';
import 'package:hive/hive.dart';
part '../hive_generated.dart/category_type_model.g.dart';

@HiveType(typeId: 1)
// ignore: must_be_immutable
class CategoryType extends Equatable {
  @HiveField(0)
  String id;
  @HiveField(1)
  String type;
  @HiveField(2)
  Employee responsible;
  @HiveField(3)
  List<AuditCategory> categories;

  CategoryType({
    this.id,
    this.type,
    this.categories,
    this.responsible,
  });
  Map<String, dynamic> toJson() => {
        "id": id,
        "type": type,
        "responsible": responsible?.toJson(),
        "categories": categories == null
            ? []
            : categories.map((AuditCategory data) => data.toJson()).toList(),
      };

  CategoryType.fromJson(Map<String, dynamic> parsedJson) {
    if (parsedJson == null) {
      return;
    }

    id = parsedJson['id'];
    type = parsedJson['type'];
    responsible = parsedJson['responsible'] != null
        ? Employee.fromJson(parsedJson['responsible'])
        : null;
    categories = parsedJson['categories'] == null
        ? []
        : (parsedJson['categories'] as List<dynamic>)
            .map((i) => AuditCategory.fromJson(i))
            .toList();
  }

  @override
  List<Object> get props => [id, type, categories];
}
