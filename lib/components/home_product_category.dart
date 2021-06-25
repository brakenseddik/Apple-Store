import 'package:flutter/material.dart';
import 'package:planety_app/views/products/products_category_screen.dart';

class HomeProductCategory extends StatefulWidget {
  final String categoryIcon;
  final String categoryName;
  final int id;
  HomeProductCategory(this.categoryIcon, this.categoryName, this.id);
  @override
  _HomeProductCategoryState createState() => _HomeProductCategoryState();
}

class _HomeProductCategoryState extends State<HomeProductCategory> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => ProductsCategoryScreen(
                      id: widget.id,
                      category: widget.categoryName,
                    )));
      },
      child: Container(
        width: 105,
        height: 105,
        child: Card(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Image.network(
                widget.categoryIcon,
                width: 80.0,
                height: 80.0,
              ),
              Text(widget.categoryName),
            ],
          ),
        ),
      ),
    );
  }
}
