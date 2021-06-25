import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:planety_app/constants.dart';
import 'package:planety_app/controllers/product_controller.dart';
import 'package:planety_app/models/product_model.dart';
import 'package:planety_app/views/products/product_screen.dart';

class ProductsCategoryScreen extends StatefulWidget {
  final int? id;
  final String? category;
  ProductsCategoryScreen({@required this.id, @required this.category});
  @override
  _ProductsCategoryScreenState createState() => _ProductsCategoryScreenState();
}

class _ProductsCategoryScreenState extends State<ProductsCategoryScreen> {
  ProductController _productController = ProductController();
  List<ProductModel> _productList = <ProductModel>[];

  getProductsByCategory() async {
    var products = await _productController.getProductsByCategory(widget.id);
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
        setState(() {
          _productList.add(model);
        });
      });
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getProductsByCategory();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          widget.category.toString(),
          style: TextStyle(color: Colors.black),
        ),
      ),
      body: _productList.length > 0
          ? GridView.builder(
              padding: EdgeInsets.only(left: 8, right: 8, top: 15),
              gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
                  maxCrossAxisExtent: 200,
                  childAspectRatio: 2.5 / 3,
                  crossAxisSpacing: 5,
                  mainAxisSpacing: 5),
              itemBuilder: (context, index) => GestureDetector(
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => ProductScreen(
                                productModel: _productList[index],
                              )));
                },
                child: Card(
                  child: Column(
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(5),
                            topRight: Radius.circular(5)),
                        child: Image.network(
                          _productList[index].photo,
                          height: 160,
                          width: double.infinity,
                          fit: BoxFit.cover,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(_productList[index].name),
                      )
                    ],
                  ),
                ),
              ),
              itemCount: _productList.length,
            )
          : Center(
              child: Text('Empty list'),
            ),
    );
  }
}
