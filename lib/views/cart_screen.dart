import 'package:flutter/material.dart';
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
  GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  CartController _cartController = CartController();
  late List<ProductModel> _cartList = [];
  late double total = 0.0;

  void _checkout(List<ProductModel> cartItems) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var userId = prefs.getInt('userId');
    if (userId != null && userId > 0) {
      Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => CheckoutScreen(
                    cartList: _cartList,
                  )));
    } else {
      Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => SignInScreen(
                    cartList: _cartList,
                  )));
    }
  }

  getCartItems() async {
    var cartItems = await _cartController.getCartItems();
    cartItems.forEach((product) {
      ProductModel model = ProductModel();
      model.id = product['productId'];
      model.name = product['productName'];
      model.photo = product['productPhoto'];
      model.price = product['productPrice'].toDouble();
      model.discount = product['productDiscount'].toDouble();
      model.quantity = product['productQuantity'];

      setState(() {
        _cartList.add(model);
      });
    });
    _cartList.forEach((item) {
      setState(() {
        total += (item.price - item.discount) * item.quantity;
      });
    });
  }

  _showSnackMessage(message) {
    var snackBar = SnackBar(
      content: message,
    );
    _scaffoldKey.currentState!.showSnackBar(snackBar);
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getCartItems();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Cart (${_cartList.length} items)',
            style: TextStyle(color: Colors.black)),
      ),
      bottomNavigationBar: InkWell(
        onTap: () {
          _checkout(_cartList);
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
                '£' + total.toString(),
                style: TextStyle(color: Colors.white),
              )
            ],
          ),
        ),
      ),
      body: _cartList.length > 0
          ? ListView.builder(
              padding: EdgeInsets.symmetric(horizontal: 8, vertical: 12),
              itemBuilder: (context, index) {
                return Dismissible(
                  key: Key(this._cartList[index].name),
                  onDismissed: (val) {
                    _deleteCartItem(index, this._cartList[index].id);
                  },
                  background: Container(
                      child: Align(
                          alignment: Alignment.centerRight,
                          child: Padding(
                            padding: const EdgeInsets.only(right: 28.0),
                            child: Icon(
                              Icons.delete_outline_outlined,
                              size: 36,
                              color: Colors.white,
                            ),
                          )),
                      color: Colors.redAccent),
                  child: Card(
                    elevation: 5,
                    shape: OutlineInputBorder(
                        borderRadius: BorderRadius.all(
                      Radius.circular(7),
                    )),
                    child: Container(
                      margin: EdgeInsets.all(4),
                      height: 120,
                      child: Row(
                        children: [
                          Expanded(
                            flex: 3,
                            child: ClipRRect(
                              borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(5),
                                  topRight: Radius.circular(5)),
                              child: Image.network(
                                _cartList[index].photo,
                                width: 150,
                                height: 120,
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                          Expanded(
                              flex: 5,
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Text(
                                      _cartList[index].name,
                                      overflow: TextOverflow.clip,
                                      style: TextStyle(
                                          fontWeight: FontWeight.w500,
                                          fontSize: 16),
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Text(
                                      '${_cartList[index].price - _cartList[index].discount} ' +
                                          " x " +
                                          _cartList[index].quantity.toString(),
                                      style: TextStyle(
                                          fontWeight: FontWeight.w500),
                                    ),
                                  ),
                                ],
                              )),
                          Expanded(
                              child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              IconButton(
                                icon: Icon(Icons.keyboard_arrow_up),
                                onPressed: () {
                                  setState(() {
                                    total += this._cartList[index].price -
                                        this._cartList[index].discount;
                                    this._cartList[index].quantity++;
                                  });
                                },
                              ),
                              Text(_cartList[index].quantity.toString()),
                              IconButton(
                                icon: Icon(Icons.keyboard_arrow_down),
                                onPressed: () {
                                  setState(() {
                                    if (_cartList[index].quantity > 1) {
                                      total -= (this._cartList[index].price -
                                          this._cartList[index].discount);
                                      this._cartList[index].quantity--;
                                    }
                                  });
                                },
                              ),
                            ],
                          ))
                        ],
                      ),
                    ),
                  ),
                );
              },
              itemCount: _cartList.length,
            )
          : Center(
              child: Text('Your Shopping cart is empty'),
            ),
    );
  }

  _deleteCartItem(int index, id) async {
    print(_cartList.length);
    setState(() {
      _cartList.removeAt(index);
    });
    print(_cartList.length);
    var result = await _cartController.deleteItem(id);
    print(result);
  }
}
