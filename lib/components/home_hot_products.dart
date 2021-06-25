import 'package:flutter/material.dart';
import 'package:planety_app/models/product_model.dart';

import 'home_hot_product.dart';

class HomeHotProducts extends StatefulWidget {
  final List<ProductModel> productList;
  HomeHotProducts({required this.productList});
  @override
  _HomeHotProductsState createState() => _HomeHotProductsState();
}

class _HomeHotProductsState extends State<HomeHotProducts> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(left: 5, right: 5),
      height: 220,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: this.widget.productList.length,
        itemBuilder: (context, index) {
          return HomeHotProduct(this.widget.productList[index]);
        },
      ),
    );
  }
}
