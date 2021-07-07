import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
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
                    suffixIcon: Icon(Icons.visibility_off),
                    hintText: 'Enter your password',
                    labelText: 'Password'),
              ),
            ),
            Column(
              children: <Widget>[
                ButtonTheme(
                  minWidth: MediaQuery.of(context).size.width - 96,
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
                  child: FittedBox(
                      child: Text(
                    'Register your account',
                    textAlign: TextAlign.right,
                  )),
                ),
              ],
            ),
            SizedBox(
              height: 30,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                SizedBox(
                  width: 150,
                  child: Divider(
                    thickness: 2,
                    color: Colors.black,
                  ),
                ),
                Text(
                  'Or',
                  textAlign: TextAlign.center,
                ),
                SizedBox(
                  width: 150,
                  child: Divider(
                    thickness: 2,
                    color: Colors.black,
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 30,
            ),
            Column(
              children: [
                Container(
                  margin: EdgeInsets.symmetric(vertical: 5),
                  height: 50,
                  width: MediaQuery.of(context).size.width - 96,
                  decoration: BoxDecoration(
                      border: Border.all(width: 2, color: Colors.grey)),
                  child: Row(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Icon(
                          FontAwesomeIcons.google,
                          size: 28,
                        ),
                      ),
                      Spacer(),
                      Text(
                        'Google Sign In',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      Spacer()
                    ],
                  ),
                ),
                Container(
                  margin: EdgeInsets.symmetric(vertical: 5),
                  height: 50,
                  width: MediaQuery.of(context).size.width - 96,
                  decoration: BoxDecoration(
                      border: Border.all(width: 2, color: Colors.grey)),
                  child: Row(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Icon(
                          FontAwesomeIcons.facebookF,
                          size: 28,
                        ),
                      ),
                      Spacer(),
                      Text(
                        'Facebook Sign In',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      Spacer()
                    ],
                  ),
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
