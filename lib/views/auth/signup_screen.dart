import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:planety_app/controllers/user_controller.dart';
import 'package:planety_app/models/product_model.dart';
import 'package:planety_app/models/user_model.dart';
import 'package:planety_app/views/auth/signin_screen.dart';
import 'package:planety_app/views/checkout_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SignUpScreen extends StatefulWidget {
  final List<ProductModel>? cartItems;
  SignUpScreen({this.cartItems});
  @override
  _SignUpScreenState createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final name = TextEditingController();

  final email = TextEditingController();

  final password = TextEditingController();
  UserController _userController = UserController();

  _register(BuildContext context, UserModel user) async {
    var registerUser = await _userController.createUser(user);
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
              builder: (context) =>
                  CheckoutScreen(cartList: widget.cartItems)));
    } else {
      print('failed to register');
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
        padding: const EdgeInsets.only(top: 100.0),
        child: ListView(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.only(
                  left: 28.0, top: 14.0, right: 28.0, bottom: 14.0),
              child: TextField(
                controller: name,
                decoration: InputDecoration(
                    hintText: 'Enter your name', labelText: 'Enter your name'),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(
                  left: 28.0, top: 14.0, right: 28.0, bottom: 14.0),
              child: TextField(
                keyboardType: TextInputType.emailAddress,
                controller: email,
                decoration: InputDecoration(
                    hintText: 'Enter your email address',
                    labelText: 'Enter your email address'),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(
                  left: 28.0, top: 14.0, right: 28.0, bottom: 14.0),
              child: TextField(
                controller: password,
                obscureText: true,
                decoration:
                    InputDecoration(hintText: 'Password', labelText: '******'),
              ),
            ),
            Column(
              children: <Widget>[
                ButtonTheme(
                  minWidth: 320.0,
                  height: 45.0,
                  child: FlatButton(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(7.0)),
                    color: Colors.black,
                    onPressed: () {
                      var user = UserModel();
                      user.name = name.text;
                      user.email = email.text;
                      user.password = password.text;
                      _register(context, user);
                    },
                    child:
                        Text('Register', style: TextStyle(color: Colors.white)),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(5),
                  child: FlatButton(
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => SignInScreen()));
                    },
                    child: FittedBox(child: Text('Log in to your account')),
                  ),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.only(
                  left: 65.0, top: 14.0, right: 65.0, bottom: 14.0),
              child: Text(
                'By signing up you accept the Terms of Service and Privacy Policy',
                textAlign: TextAlign.center,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
