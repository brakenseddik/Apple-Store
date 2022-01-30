import 'package:get/state_manager.dart';
import 'package:planety_app/models/product_model.dart';
import 'package:planety_app/repository/repository.dart';

class CartController extends GetxController {
  Repository _repository = Repository();
// Variables
  RxDouble total = 0.0.obs;
  RxList<ProductModel> cartList = <ProductModel>[].obs;
  //List<ProductModel> get carts => [..._cartList];
  RxBool deleting = false.obs;
  RxBool loading = false.obs;
// Methods
  deleteCartItemById(id) async {
    return await _repository.deleteLocal('carts', id);
  }

  addProductToCart(ProductModel product) async {
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

  Future<int?> deleteCartItem(int index, int id) async {
    try {
      print('list length:' + cartList.length.toString());
      int result = await deleteCartItemById(id);

      cartList.removeAt(index);

      print('result:' + result.toString());
      print('list length:' + cartList.length.toString());
      cartList.refresh();
      return result;
    } catch (e) {
      print('exception : ' + e.toString());
    }
  }

  getCarts() async {
    var cartItems = await _repository.getAllLocal('carts');

    cartItems.forEach((product) {
      final ProductModel model = ProductModel();
      model.id = product['productId'];
      model.name = product['productName'];
      model.photo = product['productPhoto'];
      model.price = product['productPrice'].toDouble();
      model.discount = product['productDiscount'].toDouble();
      model.quantity = product['productQuantity'];

      cartList.add(model);
    });
    calculateTotale(cartList);
  }

  calculateTotale(List<ProductModel> products) {
    products.forEach((item) {
      total.value += (item.price - item.discount) * item.quantity;
    });
  }

  @override
  void onInit() {
    super.onInit();
    getCarts();
  }
}
