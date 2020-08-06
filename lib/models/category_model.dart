class CategoryType {
  String id;
  String type;
  List<Category> categories;

  CategoryType({this.id, this.type});
  Map<String, dynamic> toJson() => {"id": id, "type": type};

  CategoryType.fromJson(Map<String, dynamic> parsedJson) {
    if (parsedJson == null) {
      return;
    }

    id = parsedJson['id'].toString();
    type = parsedJson['type'].toString();
    categories = (parsedJson['categoryes'] as List<dynamic>)
        .map((i) => Category.fromJson(i))
        .toList();
  }
}

class Category {
  String id;
  String category;
  Category({this.id, this.category});

  Map<String, dynamic> toJson() => {"id": id, "category": category};

  Category.fromJson(Map<String, dynamic> parsedJson) {
    if (parsedJson == null) {
      return;
    }
    id = parsedJson['id'].toString();
    category = parsedJson['category'].toString();
  }
}
