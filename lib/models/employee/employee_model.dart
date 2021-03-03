import 'package:hive/hive.dart';
part '../hive_generated.dart/employee_model.g.dart';

@HiveType(typeId: 0)
class Employee {
  @HiveField(0)
  String id;
  @HiveField(1)
  String firstName;
  @HiveField(2)
  String lastName;
  @HiveField(3)
  String role;
  @HiveField(4)
  String email;
  @HiveField(5)
  String createdDate;

  Employee(
      {this.id,
      this.firstName,
      this.lastName,
      this.createdDate,
      this.role,
      this.email});

  Map<String, dynamic> toJson() => {
        "id": id,
        "firstName": firstName,
        "lastName": lastName,
        "role": role,
        "email": email
      };

  factory Employee.fromJson(Map<String, dynamic> parsedJson) {
    return Employee(
      id: parsedJson['id'],
      firstName: parsedJson['firstName'],
      lastName: parsedJson['lastName'],
      role: parsedJson['role'],
      email: parsedJson['email'],
      createdDate: parsedJson['created_date'],
    );
  }

  set setId(String id) => this.id = id;
  set setFirstName(String firstName) => this.firstName = firstName;
  set setLastName(String lastName) => this.lastName = lastName;
  set setCreatedDate(String createdDate) => this.createdDate = createdDate;
  set setEmail(String email) => this.email = email;
}
