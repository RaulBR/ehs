

class Employee {
  String id;
  String userId;
  String firstName;
  String lastName;
  String email;
  String company;
  String phone;
  String birthday;
  bool checked;
  String createdDate;

  Employee(
      {this.id,
      this.userId,
      this.firstName,
      this.lastName,
      this.email,
      this.company,
      this.phone,
      this.birthday,
      this.checked,
      this.createdDate});

  Map<String, dynamic> toJson() {
    if (id == null) {
      return toJsonNoid();
    }
    return toJsonId();
  }

  Map<String, dynamic> toJsonId() => {
        "_id": id != null ? id : '',
        "user_id": "$userId",
        "firstName": "$firstName",
        "lastName": "$lastName",
        "email": "$email",
        "company": "$company",
        "phone": "$phone",
        "birthday": "$birthday",
        "checked": "$checked",
      };

  Map<String, dynamic> toJsonNoid() => {
        "firstName": "$firstName",
        "lastName": "$lastName",
        "email": "$email",
        "company": "$company",
        "phone": "$phone",
        "birthday": "$birthday",
        "checked": "$checked",
      };



  Employee.fromJson(Map<String, dynamic> parsedJson) {
    id = parsedJson['_id'].toString();
    userId = parsedJson['_user_id'].toString();
    firstName = parsedJson['firstName'].toString();
    lastName = parsedJson['lastName'].toString();
    email = parsedJson['email'].toString();
    company = parsedJson['company'].toString();
    phone = parsedJson['phone'].toString();
    birthday = parsedJson['birthday'].toString();
    checked = parsedJson['checked'];
    createdDate = parsedJson['created_date'].toString();
  }

  set setId(String id) => this.id = id;
  set setUserId(String userId) => this.userId = userId;
  set setFirstName(String firstName) => this.firstName = firstName;
  set setLastName(String lastName) => this.lastName = lastName;
  set setEmail(String email) => this.email = email;
  set setCompany(String company) => this.company = company;
  set setPhone(String phone) => this.phone = phone;
  set setBirthday(String birthday) => this.birthday = birthday;
  set setChecked(bool checked) => this.checked = checked;
  set setCreatedDate(String createdDate) => this.createdDate = createdDate;
}
