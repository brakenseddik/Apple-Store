import 'package:planety_app/models/product_model.dart';
import 'package:planety_app/repository/repository.dart';

class CartController {
  late Repository _repository;

  CartController() {
    _repository = Repository();
  }

  addToCart(ProductModel product) async {
    List<Map> items =
        await _repository.getLocalByCondition('carts', 'productId', product.id);
    if (items.length > 0) {
      product.quantity = items.first['productQuantity'] + 1;
      return await _repository.updateLocal(
          'carts', 'productId', product.toMap());
    }

    product.quantity = 1;
    return await _repository.saveLocal('carts', product.toMap());
  }

  getCartItems() async {
    return await _repository.getAllLocal('carts');
  }

  deleteItem(id) async {
    return await _repository.deleteLocal('carts', id);
  }
}
