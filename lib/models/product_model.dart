class ProductModel {
  late int id;
  late String name, photo;
  late double price, discount;

  late int quantity;

  toMap() {
    var map = Map<String, dynamic>();
    map['productId'] = id;
    map['productName'] = name;
    map['productPhoto'] = photo;
    map['productPrice'] = price;
    map['productDiscount'] = discount;
    map['productQuantity'] = quantity;
    return map;
  }

  fromMap() {}
}
