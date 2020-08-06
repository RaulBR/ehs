class Employee {
  String id;
  String firstName;
  String lastName;
  String role;
  String createdDate;

  Employee(
      {this.id, this.firstName, this.lastName, this.createdDate, this.role});

  Map<String, dynamic> toJson() => {
        "id": id != null ? id : '',
        "firstName": firstName,
        "lastName": lastName,
        "role": role
      };

  Employee.fromJson(Map<String, dynamic> parsedJson) {
    id = parsedJson['id'].toString();
    firstName = parsedJson['firstName'].toString();
    lastName = parsedJson['lastName'].toString();
    role = parsedJson['role'].toString();
    createdDate = parsedJson['created_date'].toString();
  }

  set setId(String id) => this.id = id;
  set setFirstName(String firstName) => this.firstName = firstName;
  set setLastName(String lastName) => this.lastName = lastName;
  set setCreatedDate(String createdDate) => this.createdDate = createdDate;
}
