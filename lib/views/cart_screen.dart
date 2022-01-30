import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:planety_app/components/cart_card.dart';
import 'package:planety_app/controllers/cart_controller.dart';
import 'package:planety_app/models/product_model.dart';
import 'package:planety_app/views/auth/signin_screen.dart';
import 'package:planety_app/views/checkout_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CartScreen extends StatefulWidget {
  @override
  _CartScreenState createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  final CartController _cartController = Get.find();

  void _checkout() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var userId = prefs.getInt('userId');
    if (userId != null && userId > 0) {
      Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => CheckoutScreen(
                    cartList: _cartController.cartList,
                  )));
    } else {
      Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => SignInScreen(
                    cartList: _cartController.cartList,
                  )));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return Scaffold(
          appBar: AppBar(
              title: Text('Cart (${_cartController.cartList.length} items)',
                  style: TextStyle(color: Colors.black))),
          bottomNavigationBar: GestureDetector(
              onTap: () {
                _checkout();
              },
              child: Container(
                color: Colors.black,
                height: 55,
                margin: EdgeInsets.all(8),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Checkout',
                      style: TextStyle(color: Colors.white),
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Text(
                      '£' + _cartController.total.toString(),
                      style: TextStyle(color: Colors.white),
                    )
                  ],
                ),
              )),
          body: _cartController.loading.isTrue
              ? Center(child: CircularProgressIndicator())
              : _cartController.cartList.length > 0
                  ? ListView.builder(
                      padding:
                          EdgeInsets.symmetric(horizontal: 8, vertical: 12),
                      itemBuilder: (context, index) {
                        return ProductCartCard(
                          cartController: _cartController,
                          index: index,
                        );
                      },
                      itemCount: _cartController.cartList.length,
                    )
                  : Center(
                      child: Text('Your Shopping cart is empty'),
                    ));
    });
  }
}
