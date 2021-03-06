import 'dart:convert';

import 'package:planety_app/models/product_model.dart';

class PaymentModel {
  int? id, userId;
  String? name;
  String? email;
  String? cardNumber;
  String? expiryMonth;
  String? expiryYear;
  String? cvcNumber;
  late List<ProductModel> cartItems;
  toJson() {
    var items = json.encode(cartItems.map((value) => value.toMap()).toList());
    //json.encoder.convert(cartItems)
    return {
      'id': id.toString(),
      'userId': userId.toString(),
      'name': name,
      'email': email,
      'cardNumber': cardNumber,
      'expiryMonth': expiryMonth,
      'expiryYear': expiryYear,
      'cvcNumber': cvcNumber,
      'cartItems': items,
    };
  }
}
