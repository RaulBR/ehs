class PaginationObject {
  int fromRow;
  int toRow;
  String searchQuerry;
  PaginationObject({this.fromRow, this.toRow, this.searchQuerry});
  Map<String, dynamic> toJson() =>
      {"fromRow": fromRow, "toRow": toRow, "searchQuerry": searchQuerry};
}
