import 'package:planety_app/repository/repository.dart';

class CategoryController {
  late Repository _repository;

  CategoryController() {
    _repository = Repository();
  }

  getCategories() async {
    return await _repository.httpGet('categories');
  }
}
