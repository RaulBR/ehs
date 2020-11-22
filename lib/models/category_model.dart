import 'package:equatable/equatable.dart';

class CategoryType extends Equatable {
  String id;
  String type;
  List<Category> categories;

  CategoryType({
    this.id,
    this.type,
    this.categories,
  });
  Map<String, dynamic> toJson() => {
        "id": id,
        "type": type,
        "categories": categories == null
            ? []
            : categories.map((Category data) => data.toJson()).toList(),
      };

  CategoryType.fromJson(Map<String, dynamic> parsedJson) {
    if (parsedJson == null) {
      return;
    }

    id = parsedJson['id'];
    type = parsedJson['type'];
    categories = parsedJson['categories'] == null
        ? []
        : (parsedJson['categories'] as List<dynamic>)
            .map((i) => Category.fromJson(i))
            .toList();
  }

  @override
  List<Object> get props => [id, type, categories];
}

class Category extends Equatable {
  String id;
  String category;
  Category({this.id, this.category});

  Map<String, dynamic> toJson() => {"id": id, "category": category};

  Category.fromJson(Map<String, dynamic> parsedJson) {
    if (parsedJson == null) {
      return;
    }
    id = parsedJson['id'] ?? null;
    category = parsedJson['category'].toString() ?? null;
  }

  @override
  List<Object> get props => [id, category];
}
