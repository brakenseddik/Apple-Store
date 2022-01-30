import 'dart:convert';

class ShippingModel {
 int? id;
  String? name;
  String? email;
  String? address;

  toJson(){
    return {
      'id' : id.toString(),
      'name' : name,
      'email' : email,
      'address' : address
    };
  }
}
