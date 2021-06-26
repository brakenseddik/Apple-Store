import 'package:flutter/material.dart';
import 'package:planety_app/models/product_model.dart';

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
              keyboardType: TextInputType.emailAddress,
              controller: _cardHolderEmail,
              decoration: InputDecoration(
                hintText: 'Email',
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
                  onPressed: () {},
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
}
