import 'package:planety_app/repository/repository.dart';

class ProductController {
  late Repository _repository;

  ProductController() {
    _repository = Repository();
  }

  getHotProduct() async {
    return await _repository.httpGet('hot-products');
  }

  getProduct() async {
    return await _repository.httpGet('products');
  }

  getProductsByCategory(id) async {
    return await _repository.httpGetById('products-by-category', id);
  }
}
