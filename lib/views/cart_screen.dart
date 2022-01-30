import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:planety_app/controllers/cart_controller.dart';

class CartScreen extends StatefulWidget {
  @override
  _CartScreenState createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  final CartController _cartController = Get.find();

  /* void _checkout(List<ProductModel> cartItems) async {
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
  }*/

  

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return Scaffold(
          appBar: AppBar(
              title: Text('Cart (${_cartController.cartList.length} items)',
                  style: TextStyle(color: Colors.black))),
          bottomNavigationBar: InkWell(
              onTap: () {
                //_checkout(_cartController.cartList);
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
                        return Dismissible(
                          key: Key(this
                              ._cartController
                              .cartList[index]
                              .id
                              .toString()),
                          onDismissed: (val) async {
                            var x = await _cartController.deleteCartItem(
                                index, this._cartController.cartList[index].id);
                            if (x! > 0)
                              Fluttertoast.showToast(msg: 'deleted');
                            else {
                              Fluttertoast.showToast(msg: x.toString());
                            }
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
                                        _cartController.cartList[index].photo,
                                        width: 150,
                                        height: 120,
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                  ),
                                  Expanded(
                                      flex: 5,
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Text(
                                              _cartController
                                                  .cartList[index].name,
                                              overflow: TextOverflow.clip,
                                              style: TextStyle(
                                                  fontWeight: FontWeight.w500,
                                                  fontSize: 16),
                                            ),
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Text(
                                              '${_cartController.cartList[index].price - _cartController.cartList[index].discount} ' +
                                                  " x " +
                                                  _cartController
                                                      .cartList[index].quantity
                                                      .toString(),
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
                                          _cartController.total.value += this
                                                  ._cartController
                                                  .cartList[index]
                                                  .price -
                                              this
                                                  ._cartController
                                                  .cartList[index]
                                                  .discount;
                                          this
                                              ._cartController
                                              .cartList[index]
                                              .quantity++;
                                        },
                                      ),
                                      Text(_cartController
                                          .cartList[index].quantity
                                          .toString()),
                                      IconButton(
                                        icon: Icon(Icons.keyboard_arrow_down),
                                        onPressed: () {
                                          if (_cartController
                                                  .cartList[index].quantity >
                                              1) {
                                            _cartController.total.value -= (this
                                                    ._cartController
                                                    .cartList[index]
                                                    .price -
                                                this
                                                    ._cartController
                                                    .cartList[index]
                                                    .discount);
                                            this
                                                ._cartController
                                                .cartList[index]
                                                .quantity--;
                                          }
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
                      itemCount: _cartController.cartList.length,
                    )
                  : Center(
                      child: Text('Your Shopping cart is empty'),
                    ));
    });
  }
}
