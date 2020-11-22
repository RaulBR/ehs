class User {
  String email;
  String password;
  String password2;
  String role;
  String id;
  String token;

  User({this.id, this.email, this.token, this.password, this.password2});
  Map<String, dynamic> toJson() => {
        "email": "$email",
        "password": "$password",
      };

  Map<String, dynamic> getJsonToken() => {"token": "$token", "id": "$id"};

  User fromJson(Map<String, dynamic> parsedJson) {
    return User.fromJson(parsedJson);
  }

  User.fromJson(Map<String, dynamic> parsedJson) {
    id = parsedJson['id']?.toString();
    password = parsedJson['password']?.toString();
    email = parsedJson['email']?.toString();
    role = parsedJson['role']?.toString();
    token = parsedJson['token']?.toString();
  }
}
