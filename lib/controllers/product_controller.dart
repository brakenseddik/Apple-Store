import 'dart:convert';

import 'package:get/get.dart';
import 'package:planety_app/constants.dart';
import 'package:planety_app/models/product_model.dart';
import 'package:planety_app/repository/remote_service.dart';

class ProductController extends GetxController {
  Repository _repository = Repository();
  RxBool loading = false.obs;
  RxBool loadingTwo = false.obs;
  RxBool loading3 = false.obs;

  RxList<ProductModel> productList = <ProductModel>[].obs;
  RxList<ProductModel> allproductList = <ProductModel>[].obs;
  RxList<ProductModel> productsByCategory = <ProductModel>[].obs;

  getHotProduct() async {
    return await _repository.httpGet('hot-products');
  }

  getProduct() async {
    return await _repository.httpGet('products');
  }

  getProductsByCategory(id) async {
    return await _repository.httpGetById('products-by-category', id);
  }

  getAllProductsByCategory(int id) async {
    loading3.value = true;
    var products = await getProductsByCategory(id);
    var result = jsonDecode(products.body);
    if (result != null) {
      print(result);

      result['data'].forEach((product) {
        var model = ProductModel();

        String imageUrl = product['photo'].toString();
        String img = imageUrl.substring(21, imageUrl.length);
        model.id = product['id'];
        model.name = product['name'];
        model.price = product['price'].toDouble();
        model.discount = product['discount'].toDouble();
        model.photo = baseUrl + img;
        productsByCategory.add(model);
      });
    }
        loading3.value = false;

  }

  getAllHotProducts() async {
    loading.value = true;
    var products = await getHotProduct();
    var result = jsonDecode(products.body);
    if (result!= null) {
      result['data'].forEach((product) {
        var model = ProductModel();
        String imageUrl = product['photo'].toString();
        String img = imageUrl.substring(21, imageUrl.length);
        model.id = product['id'];
        model.name = product['name'];
        model.price = product['price'].toDouble();
        model.discount = product['discount'].toDouble();
        model.photo = baseUrl + img ;

        productList.add(model);
      });
    }
    loading.value = false;
  }

  getAllProducts() async {
    loadingTwo.value = true;
    var products = await getProduct();
    var result = jsonDecode(products.body);
    if (result != null) {
      result['data'].forEach((product) {
        var model = ProductModel();
        String imageUrl = product['photo'].toString();
        String img = imageUrl.substring(21, imageUrl.length);
        model.id = product['id'];
        model.name = product['name'];
        model.price = product['price'].toDouble();
        model.discount = product['discount'].toDouble();
        model.photo = baseUrl + img;
        allproductList.add(model);
      });
    }
    loadingTwo.value = false;
  }

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    getAllHotProducts();
    getAllProducts();
  }
}
