class EhsResponceModel {
  String status;

  EhsResponceModel({this.status});
  EhsResponceModel.fromJson(Map<String, dynamic> parsedJson) {
    status = parsedJson['status'].toString();
  }
}
