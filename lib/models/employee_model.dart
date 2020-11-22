class Employee {
  String id;
  String firstName;
  String lastName;
  String role;
  String email;
  String createdDate;

  Employee(
      {this.id,
      this.firstName,
      this.lastName,
      this.createdDate,
      this.role,
      this.email});

  Map<String, dynamic> toJson() => {
        "id": id ?? null,
        "firstName": firstName ?? null,
        "lastName": lastName ?? null,
        "role": role ?? null,
        "email": email ?? null
      };

  Employee.fromJson(Map<String, dynamic> parsedJson) {
    id = parsedJson['id']?.toString();
    firstName = parsedJson['firstName']?.toString();
    lastName = parsedJson['lastName']?.toString();
    role = parsedJson['role']?.toString();
    email = parsedJson['email']?.toString();
    createdDate = parsedJson['created_date']?.toString();
  }

  set setId(String id) => this.id = id;
  set setFirstName(String firstName) => this.firstName = firstName;
  set setLastName(String lastName) => this.lastName = lastName;
  set setCreatedDate(String createdDate) => this.createdDate = createdDate;
  set setEmail(String email) => this.email = email;
}
