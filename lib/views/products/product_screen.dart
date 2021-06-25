import 'package:flutter/material.dart';
import 'package:planety_app/controllers/cart_controller.dart';
import 'package:planety_app/models/product_model.dart';

class ProductScreen extends StatefulWidget {
  final ProductModel? productModel;
  const ProductScreen({Key? key, this.productModel}) : super(key: key);

  @override
  _ProductScreenState createState() => _ProductScreenState();
}

class _ProductScreenState extends State<ProductScreen> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  CartController _cartService = CartController();

  _addToCart(BuildContext context, ProductModel product) async {
    var result = await _cartService.addToCart(product);
    if (result > 0) {
      _showSnackMessage(Text(
        'Item added to cart successfully!',
        style: TextStyle(color: Colors.green),
      ));
    } else {
      _showSnackMessage(Text(
        'Failed to add to cart!',
        style: TextStyle(color: Colors.red),
      ));
    }
  }

  _showSnackMessage(message) {
    var snackBar = SnackBar(
      content: message,
    );
    _scaffoldKey.currentState!.showSnackBar(snackBar);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        title: Text(
          widget.productModel!.name,
          style: TextStyle(color: Colors.black),
          overflow: TextOverflow.ellipsis,
        ),
      ),
      bottomNavigationBar: InkWell(
        onTap: () {
          _addToCart(context, widget.productModel!);
        },
        child: Container(
          color: Colors.black,
          height: 55,
          margin: EdgeInsets.all(8),
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
          Image.network(widget.productModel!.photo,
              height: MediaQuery.of(context).size.height / 2.5,
              fit: BoxFit.contain),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              widget.productModel!.name,
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.w700),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  '£' + widget.productModel!.price.toString(),
                  style: TextStyle(
                      color: Colors.black, fontWeight: FontWeight.w700),
                ),
                Text(
                  '£${widget.productModel!.price - widget.productModel!.discount}',
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
