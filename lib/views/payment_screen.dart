import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:planety_app/controllers/cart_controller.dart';
import 'package:planety_app/controllers/payment_controller.dart';
import 'package:planety_app/models/payment_model.dart';
import 'package:planety_app/models/product_model.dart';
import 'package:planety_app/views/home_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

class PayementScreen extends StatefulWidget {
  final List<ProductModel>? cartList;

  const PayementScreen({this.cartList});

  @override
  _PayementScreenState createState() => _PayementScreenState();
}

class _PayementScreenState extends State<PayementScreen> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  final _cardHolderName = TextEditingController();
  final _cardHolderEmail = TextEditingController();
  final _cardNumber = TextEditingController();
  final _expiryMonth = TextEditingController();
  final _expiryYear = TextEditingController();
  final _cvcNumber = TextEditingController();

  /*_showSnackMessage(message) {
    var snackBar = SnackBar(
      content: message,
    );
    _scaffoldKey.currentState!.showSnackBar(snackBar);
  }*/
  _makePayment(BuildContext context, PaymentModel payment) async {
    PaymentController _paymentService = PaymentController();
    var paymentData = await _paymentService.makePayment(payment);
    print(paymentData.body);
    var result = jsonDecode(paymentData.body);
    print('result' + result.toString());
    if (result['result'] == true) {
      _showSuccessPaymentMessage(context);
      // CartController cartController = CartController();
      // widget.cartList!.forEach((item) {
      //   cartController.deleteCartItemById(item.id);
      // });
      Timer(Duration(seconds: 2), () {
        Navigator.pop(context);
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => HomeScreen()));
      });
    } else {
      // CartController cartController = CartController();
      // widget.cartList!.forEach((item) {
      //   cartController.deleteCartItemById(item.id);
      // });
      showDialog(
          context: context,
          barrierDismissible: true,
          builder: (context) {
            return AlertDialog(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(10))),
              content: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(
                    Icons.warning_amber_rounded,
                    size: 55,
                  ),
                  Text(
                    'Payment didnt go right',
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 24),
                  ),
                ],
              ),
            );
          });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text(
          'Payment',
          style: TextStyle(color: Colors.black),
        ),
        elevation: 0.0,
      ),
      body: ListView(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.only(
                left: 28.0, top: 28.0, right: 28.0, bottom: 14.0),
            child: Text('Make payment',
                style: TextStyle(fontSize: 28.0, fontWeight: FontWeight.bold)),
          ),
          Divider(
            height: 5.0,
            color: Colors.black,
          ),
          Padding(
            padding: const EdgeInsets.only(
                left: 28.0, top: 14.0, right: 28.0, bottom: 14.0),
            child: TextField(
              controller: _cardHolderName,
              decoration: InputDecoration(
                hintText: 'Name',
                border: new OutlineInputBorder(),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.black54, width: 2.0),
                ),
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.black, width: 2.0),
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(
                left: 28.0, top: 14.0, right: 28.0, bottom: 14.0),
            child: TextField(
              controller: _cardNumber,
              decoration: InputDecoration(
                hintText: 'Card Number',
                border: new OutlineInputBorder(),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.black54, width: 2.0),
                ),
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.black, width: 2.0),
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(
                left: 28.0, top: 14.0, right: 28.0, bottom: 14.0),
            child: TextField(
              controller: _expiryMonth,
              decoration: InputDecoration(
                hintText: 'Expiry Month',
                border: new OutlineInputBorder(),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.black54, width: 2.0),
                ),
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.black, width: 2.0),
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(
                left: 28.0, top: 14.0, right: 28.0, bottom: 14.0),
            child: TextField(
              controller: _expiryYear,
              decoration: InputDecoration(
                hintText: 'Expiry Year',
                border: new OutlineInputBorder(),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.black54, width: 2.0),
                ),
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.black, width: 2.0),
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(
                left: 28.0, top: 14.0, right: 28.0, bottom: 14.0),
            child: TextField(
                controller: _cvcNumber,
                obscureText: true,
                decoration: InputDecoration(
                  hintText: 'CVC',
                  border: new OutlineInputBorder(),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.black54, width: 2.0),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.black, width: 2.0),
                  ),
                )),
          ),
          Column(
            children: <Widget>[
              ButtonTheme(
                minWidth: MediaQuery.of(context).size.width - 56,
                height: 50.0,
                child: FlatButton(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(7.0)),
                  color: Colors.black,
                  onPressed: () async {
                    SharedPreferences prefs =
                        await SharedPreferences.getInstance();
                    var payment = PaymentModel();
                    payment.userId = prefs.getInt('userId');
                    print(prefs.getInt('userId').toString());
                    payment.name = _cardHolderName.text;
                    payment.email = _cardHolderEmail.text;
                    payment.cardNumber = _cardNumber.text;
                    payment.expiryMonth = _expiryMonth.text;
                    payment.expiryYear = _expiryYear.text;
                    payment.cvcNumber = _cvcNumber.text;
                    payment.cartItems = this.widget.cartList!;
                    _makePayment(context, payment);
                  },
                  child: Text('Make Payment',
                      style: TextStyle(color: Colors.white)),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  _showSuccessPaymentMessage(BuildContext context) {
    return showDialog(
        context: context,
        barrierDismissible: true,
        builder: (context) {
          return AlertDialog(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(10))),
            content: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Image.asset('assets/success.png'),
                Text(
                  'Payment completed successfully',
                  style: TextStyle(fontSize: 24),
                )
              ],
            ),
          );
        });
  }
}
