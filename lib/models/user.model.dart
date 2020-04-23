class User {
  String email;
  String password;
  User({this.email, this.password});
   Map<String, dynamic> toJson() =>
    {
      'name': email,
      'password': password,
    };
}