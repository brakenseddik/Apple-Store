class UserModel {
  int? id;
  String? email, name, password;

  toJson() {
    return {
      'id': id.toString(),
      'name': name.toString(),
      'email': email,
      'password': password,
    };
  }
}
