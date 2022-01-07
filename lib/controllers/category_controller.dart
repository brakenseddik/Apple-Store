import 'dart:convert';

import 'package:get/get.dart';
import 'package:planety_app/constants.dart';
import 'package:planety_app/models/category_model.dart';
import 'package:planety_app/repository/repository.dart';

class CategoryController extends GetxController {
  Repository _repository = Repository();

  RxList<CategoryModel> _categoryList = <CategoryModel>[].obs;

  List<CategoryModel> get categories => [..._categoryList];
  RxBool loading = false.obs;

  @override
  void onInit() {
    super.onInit();
    getAllCategories();
  }

  Future<void> getAllCategories() async {
    try {
      loading.value = true;
      final categories = await _repository.httpGet('categories');
      var result = jsonDecode(categories.body);
      if (result != null) {
        print(result);
        result['data'].forEach((category) {
          var model = CategoryModel();
          String imageUrl = category['icon'].toString();
          String img = imageUrl.substring(21, imageUrl.length);
          model.id = category['id'];
          model.name = category['name'];
          model.icon = baseUrl + img;

          _categoryList.add(model);
        });
      }
      loading.value = false;
    } catch (e) {}
  }
}
