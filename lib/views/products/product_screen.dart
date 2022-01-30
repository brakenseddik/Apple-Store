import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:planety_app/controllers/cart_controller.dart';
import 'package:planety_app/models/product_model.dart';

class ProductScreen extends StatefulWidget {
  final ProductModel productModel;
  const ProductScreen({Key? key, required this.productModel}) : super(key: key);

  @override
  _ProductScreenState createState() => _ProductScreenState();
}

class _ProductScreenState extends State<ProductScreen> {
  final CartController _cartController = Get.find();

  _addToCart(BuildContext context, ProductModel product) async {
    int? result = await _cartController.addProductToCart(product);
    if (result! > 0) {
      Fluttertoast.showToast(msg: 'Item added to cart successfully!');
    } else {
      Fluttertoast.showToast(msg: 'failed to add product!');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          widget.productModel.name,
          style: TextStyle(color: Colors.black),
          overflow: TextOverflow.ellipsis,
        ),
      ),
      bottomNavigationBar: InkWell(
        onTap: () {
          _addToCart(context, widget.productModel);
        },
        child: Container(
          color: Colors.black,
          height: 55,
          margin: EdgeInsets.all(15),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Add to Cart',
                style: TextStyle(color: Colors.white),
              ),
              SizedBox(
                width: 20,
              ),
              Icon(
                Icons.shopping_bag_outlined,
                color: Colors.white,
                size: 28,
              )
            ],
          ),
        ),
      ),
      body: ListView(
        children: [
          Image.network(widget.productModel.photo,
              height: MediaQuery.of(context).size.height / 2.5,
              fit: BoxFit.contain),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              widget.productModel.name,
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.w700),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  '£' + widget.productModel.price.toString(),
                  style: TextStyle(
                      color: Colors.black, fontWeight: FontWeight.w700),
                ),
                Text(
                  '£${widget.productModel.price - widget.productModel.discount}',
                  style:
                      TextStyle(color: Colors.red, fontWeight: FontWeight.w700),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
