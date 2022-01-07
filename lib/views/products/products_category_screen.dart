import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:planety_app/controllers/product_controller.dart';
import 'package:planety_app/models/category_model.dart';
import 'package:planety_app/views/products/product_screen.dart';

class ProductsCategoryScreen extends StatefulWidget {
  final CategoryModel categoryModel;
  ProductsCategoryScreen({required this.categoryModel});
  @override
  _ProductsCategoryScreenState createState() => _ProductsCategoryScreenState();
}

class _ProductsCategoryScreenState extends State<ProductsCategoryScreen> {
  ProductController _productController = Get.find();

  @override
  void initState() {
    super.initState();
    _productController.getAllProductsByCategory(widget.categoryModel.id);
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
         _productController.productsByCategory.clear();

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          widget.categoryModel.name,
          style: TextStyle(color: Colors.black),
        ),
      ),
      body: Obx(
        () {
          return
          
          _productController.loading3.isTrue? Center(child: CircularProgressIndicator(),) :
           _productController.productsByCategory.length > 0
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
                                    productModel: _productController
                                        .productsByCategory[index],
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
                              _productController.productsByCategory[index].photo,
                              height: 160,
                              width: double.infinity,
                              fit: BoxFit.cover,
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                                _productController.productsByCategory[index].name),
                          )
                        ],
                      ),
                    ),
                  ),
                  itemCount: _productController.productsByCategory.length,
                )
              : Center(
                  child: Text('Empty list'),
                );
        }
      ),
    );
  }
}
