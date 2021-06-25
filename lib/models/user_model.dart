class UserModel {
  int? id;
  String? email, name, password;

  toJson() {
    return {
      'id': id.toString(),
      'name': name,
      'email': email,
      'password': password,
    };
  }
}
