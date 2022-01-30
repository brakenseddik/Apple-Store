import 'package:get/state_manager.dart';
import 'package:planety_app/models/product_model.dart';
import 'package:planety_app/repository/local_service.dart';
import 'package:planety_app/repository/remote_service.dart';
import 'package:get/get.dart';
class CartController extends GetxController {
   static CartController instance = Get.find();


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
      product.quantity = items.first['ProductQuantity'] + 1;
      return await _databaseHelper.updateItem(
          'carts', 'productId', product.toMap());
    } else {
      product.quantity = 1;

      var res = await _databaseHelper.inserItem('carts', product.toMap());
      cartList.refresh();
      return res;
    }
  }

  Future<int?> deleteCartItem(int index, int id) async {
    try {
      print('list length:' + cartList.length.toString());
      cartList.removeAt(index);

      int result = await _databaseHelper.deleteItem('carts', id);

      print('result:' + result.toString());
      print('list length:' + cartList.length.toString());
      cartList.refresh();
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
