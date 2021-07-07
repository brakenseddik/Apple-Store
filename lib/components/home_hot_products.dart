import 'package:flutter/material.dart';
import 'package:planety_app/models/product_model.dart';
import 'package:shimmer/shimmer.dart';

import 'home_hot_product.dart';

class HomeHotProducts extends StatefulWidget {
  final List<ProductModel> productList;
  final bool loading;
  HomeHotProducts({required this.productList, required this.loading});
  @override
  _HomeHotProductsState createState() => _HomeHotProductsState();
}

class _HomeHotProductsState extends State<HomeHotProducts> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(left: 5, right: 5),
      height: 220,
      child: widget.loading
          ? ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: 10,
              itemBuilder: (context, index) {
                return Shimmer.fromColors(
                  baseColor: Colors.grey.shade300,
                  highlightColor: Colors.grey.shade100,
                  child: Container(
                      margin: EdgeInsets.all(8),
                      width: 160.0,
                      height: 160.0,
                      color: Colors.grey.shade300),
                );
              },
            )
          : ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: this.widget.productList.length,
              itemBuilder: (context, index) {
                return HomeHotProduct(this.widget.productList[index]);
              },
            ),
    );
  }
}
