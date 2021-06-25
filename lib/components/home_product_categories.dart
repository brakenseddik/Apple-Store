import 'package:flutter/material.dart';
import 'package:planety_app/models/category_model.dart';

import 'home_product_category.dart';

class HomeProductCategories extends StatefulWidget {
  final List<CategoryModel> categoryList;
  HomeProductCategories({required this.categoryList});
  @override
  _HomeProductCategoriesState createState() => _HomeProductCategoriesState();
}

class _HomeProductCategoriesState extends State<HomeProductCategories> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 110,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: this.widget.categoryList.length,
        itemBuilder: (context, index) {
          return HomeProductCategory(
              this.widget.categoryList[index].icon,
              this.widget.categoryList[index].name,
              this.widget.categoryList[index].id);
        },
      ),
    );
  }
}
