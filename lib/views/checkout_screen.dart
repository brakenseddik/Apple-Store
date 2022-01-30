import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:planety_app/controllers/shipping_controller.dart';
import 'package:planety_app/models/product_model.dart';
import 'package:planety_app/models/shipping_model.dart';
import 'package:planety_app/views/payment_screen.dart';

class CheckoutScreen extends StatefulWidget {
  final List<ProductModel>? cartList;
  CheckoutScreen({this.cartList});
  @override
  _CheckoutScreenState createState() => _CheckoutScreenState();
}

class _CheckoutScreenState extends State<CheckoutScreen> {
  final _name = TextEditingController();

  final _email = TextEditingController();

  final _address = TextEditingController();
  
  var _shippingService = ShippingController();


  void _addShipping(BuildContext context, ShippingModel shipping) async {
    var _shipping = await _shippingService.addShipping(shipping);
    var _result = json.decode(_shipping.body);

    if (_result['result'] == true) {
      Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => PayementScreen(
                    cartList: widget.cartList,
                  )));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Checkout',
          style: TextStyle(color: Colors.black),
        ),
        actions: <Widget>[
          IconButton(
            icon: Icon(
              Icons.close,
              color: Colors.white,
            ),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
        ],
      ),
      body: ListView(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.only(
                left: 28.0, top: 28.0, right: 28.0, bottom: 14.0),
            child: Text('Shipping Address',
                style: TextStyle(fontSize: 28.0, fontWeight: FontWeight.bold)),
          ),
          Divider(
            height: 5,
            color: Colors.black,
          ),
          Padding(
            padding: const EdgeInsets.only(
                left: 28.0, top: 14.0, right: 28.0, bottom: 14.0),
            child: TextField(
              controller: _name,
              decoration: InputDecoration(hintText: 'Name', enabled: true),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(
                left: 28.0, top: 14.0, right: 28.0, bottom: 14.0),
            child: TextField(
              keyboardType: TextInputType.emailAddress,
              controller: _email,
              decoration: InputDecoration(hintText: 'Email'),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(
                left: 28.0, top: 14.0, right: 28.0, bottom: 14.0),
            child: TextField(
              controller: _address,
              maxLines: 3,
              decoration: InputDecoration(
                hintText: 'Address',
              ),
            ),
          ),
        ],
      ),
      bottomNavigationBar: Container(
        margin: const EdgeInsets.only(left: 28.0, right: 28.0, bottom: 12.0),
        child: ButtonTheme(
          minWidth: 320.0,
          height: 50.0,
          child: FlatButton(
            color: Colors.black,
            onPressed: () {
              var model = ShippingModel();
              model.name = _name.text;
              model.email = _email.text;
              model.address = _address.text;
              _addShipping(context, model);
            },
            child: Text('Continue to payment',
                style: TextStyle(color: Colors.white)),
          ),
        ),
      ),
    );
  }
}
