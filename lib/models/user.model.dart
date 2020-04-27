

class User  {
  String email;
  String password;
  String id;
  String token;

  User({this.id, this.email, this.token, this.password});
  Map<String, dynamic> toJson() => {
        "email": "$email",
        "password": "$password",
      };

  Map<String, dynamic> getJsonToken() => {"token": "$token", "id": "$id"};

  User fromJson(Map<String, dynamic> parsedJson) {
    return  User.fromJson(parsedJson);
  }

  User.fromJson(Map<String, dynamic> parsedJson) {
    id = parsedJson['_id'].toString();
    email = parsedJson['email'].toString();
    token = parsedJson['token'].toString();
  }
}
