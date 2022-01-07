import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:planety_app/models/product_model.dart';
import 'package:planety_app/views/products/product_screen.dart';

class HomeHotProduct extends StatefulWidget {
  final ProductModel? productModel;

  HomeHotProduct(this.productModel);
  @override
  _HomeHotProductState createState() => _HomeHotProductState();
}

class _HomeHotProductState extends State<HomeHotProduct> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => ProductScreen(
                      productModel: widget.productModel,
                    )));
      },
      child: Container(
        width: MediaQuery.of(context).size.width / 2,
        //height: 240.0,
        child: Card(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              ClipRRect(
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(5), topRight: Radius.circular(5)),
                child: Image.network(
                  widget.productModel!.photo,
                  width: MediaQuery.of(context).size.width / 2,
                  height: 150.0,
                  fit: BoxFit.cover,
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(5.0),
                child: Text(
                  this.widget.productModel!.name,
                  style: TextStyle(fontWeight: FontWeight.w500, fontSize: 16),
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              Padding(
                  padding: const EdgeInsets.all(5.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Text('Price: ${this.widget.productModel!.price}'),
                      // Text('Discount: ${this.widget.productDiscount}'),
                    ],
                  ))
            ],
          ),
        ),
      ),
    );
  }
}
