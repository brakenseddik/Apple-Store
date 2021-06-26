import 'package:planety_app/models/user_model.dart';
import 'package:planety_app/repository/repository.dart';

class UserController {
  late Repository _repository;

  UserController() {
    _repository = Repository();
  }

  createUser(UserModel userModel) async {
    return await _repository.httpPost('register', userModel.toJson());
  }

  login(UserModel user) async {
    return await _repository.httpPost('login', user.toJson());
  }
}
