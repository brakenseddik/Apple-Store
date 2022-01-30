import 'dart:convert';

import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/state_manager.dart';
import 'package:planety_app/models/shipping_model.dart';
import 'package:planety_app/repository/remote_service.dart';

class ShippingController extends GetxController {
  Repository? _repository;
  ShippingController() {
    _repository = Repository();
  }
  Future<bool> addShipping(ShippingModel shipping) async {
    try {
      var shippingData =
          await _repository!.httpPost('shipping', shipping.toJson());
      var result = json.decode(shippingData.body);
      if (result['result'] == true) {
        return true;
      } else {
        return false;
      }
    } catch (e) {
      print(e.toString());

      return false;
    }
  }
}
