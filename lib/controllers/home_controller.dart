import 'dart:convert';

import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:planety_app/constants.dart';
import 'package:planety_app/repository/remote_service.dart';

class HomeController extends GetxController {
  Repository _repository = Repository();
  RxBool isLoading = false.obs;
  RxList<NetworkImage> _sliders = <NetworkImage>[].obs;

  List<NetworkImage> get sliders => [..._sliders];

  getSliders() async {
    return await _repository.httpGet('sliders');
  }

  getAllSliders() async {
    isLoading.value = true;
    var sliders = await getSliders();
    var result = jsonDecode(sliders.body);
    if (result != null) {
      result['data'].forEach((slider) {
        String imageUrl = slider['image'].toString();
        String img = imageUrl.substring(21, imageUrl.length);
        String image = baseUrl + img;

        _sliders.add(NetworkImage(image));
      });
    }
    isLoading.value = false;
    //  print(result);
  }

  @override
  void onInit() {
    super.onInit();
    getAllSliders();
  }
}
