class ShippingModel {
  int? id;
  String? name, email, address;

  toJson() {
    return {
      "id": id.toString(),
      "name": name,
      "email": email,
      "address": address
    };
  }
}
