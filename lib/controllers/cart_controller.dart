import 'package:get/state_manager.dart';
import 'package:planety_app/models/product_model.dart';
import 'package:planety_app/repository/local_service.dart';
import 'package:get/get.dart';

class CartController extends GetxController {
  // static CartController instance = Get.find();

  DatabaseHelper _databaseHelper = DatabaseHelper();
// Variables
  RxDouble total = 0.0.obs;
  RxList<ProductModel> cartList = <ProductModel>[].obs;
  //List<ProductModel> get carts => [..._cartList];
  RxBool deleting = false.obs;
  RxBool loading = false.obs;
// Methods

  addProductToCart(ProductModel product) async {
    List<Map> items =
        await _databaseHelper.getItem('carts', 'productId', product.id);

    if (items.length > 0) {
      product.quantity = items.first['productQuantity'] + 1;
      return await _databaseHelper.updateItem(
          'carts', 'productId', product.toMap());
    }
    product.quantity = 1;

    return await _databaseHelper.inserItem('carts', product.toMap());
  }

  Future<int?> deleteCartItem(int index, int id) async {
    try {
      int result = await _databaseHelper.deleteItem('carts', id);

      if (result > 0) {
        cartList.removeAt(index);
      } else {
        print('not possible');
      }

      return result;
    } catch (e) {
      print('exception : ' + e.toString());
    }
  }

  getCarts() async {
    var cartItems = await _databaseHelper.getAllItems('carts');

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
    calculateTotale();
  }

  double? calculateTotale() {
    cartList.forEach((item) {
      total.value += (item.price - item.discount) * item.quantity;
    });
  }

  @override
  void onInit() {
    super.onInit();
    getCarts();
  }
}
