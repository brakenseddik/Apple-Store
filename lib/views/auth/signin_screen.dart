import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:planety_app/controllers/user_controller.dart';
import 'package:planety_app/models/product_model.dart';
import 'package:planety_app/models/user_model.dart';
import 'package:planety_app/views/auth/signup_screen.dart';
import 'package:planety_app/views/checkout_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SignInScreen extends StatefulWidget {
  final List<ProductModel>? cartList;
  SignInScreen({this.cartList});

  @override
  _SignInScreenState createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  final email = TextEditingController();
  final password = TextEditingController();
  UserController _userController = UserController();

  _login(BuildContext context, UserModel user) async {
    var registerUser = await _userController.login(user);
    var result = jsonDecode(registerUser.body);
    if (result['result'] == true) {
      SharedPreferences preferences = await SharedPreferences.getInstance();
      preferences.setInt('userId', result['user']['id']);
      preferences.setString('userName', result['user']['name']);
      preferences.setString('userEmail', result['user']['email']);
      print(result['user']);
      Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => CheckoutScreen(cartList: widget.cartList)));
    } else {
      print('failed to login');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0.0,
        actions: <Widget>[
          IconButton(
            icon: Icon(
              Icons.close,
              color: Colors.red,
            ),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.only(top: 120),
        child: ListView(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.only(
                  left: 48.0, top: 14.0, right: 48.0, bottom: 14.0),
              child: TextField(
                controller: email,
                decoration: InputDecoration(
                    hintText: 'youremail@example.com',
                    labelText: 'Enter your email'),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(
                  left: 48.0, top: 14.0, right: 48.0, bottom: 14.0),
              child: TextField(
                controller: password,
                decoration: InputDecoration(
                    hintText: 'Enter your password', labelText: 'Password'),
              ),
            ),
            Column(
              children: <Widget>[
                ButtonTheme(
                  minWidth: 320,
                  height: 45.0,
                  child: FlatButton(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(5.0)),
                    color: Colors.black,
                    onPressed: () {
                      var user = UserModel();
                      user.email = email.text;
                      user.password = password.text;
                      _login(context, user);
                    },
                    child: Text(
                      'Log in',
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ),
                FlatButton(
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => SignUpScreen(
                                  cartItems: widget.cartList,
                                )));
                  },
                  child: FittedBox(child: Text('Register your account')),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
