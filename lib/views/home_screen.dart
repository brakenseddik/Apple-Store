import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:planety_app/components/home_hot_products.dart';
import 'package:planety_app/components/home_product_categories.dart';
import 'package:planety_app/components/slider_carousel.dart';
import 'package:planety_app/constants.dart';
import 'package:planety_app/controllers/category_controller.dart';
import 'package:planety_app/controllers/product_controller.dart';
import 'package:planety_app/controllers/slider_controller.dart';
import 'package:planety_app/models/category_model.dart';
import 'package:planety_app/models/product_model.dart';
import 'package:planety_app/views/products/product_screen.dart';
import 'package:shimmer/shimmer.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  bool isLoading = false;
  bool isLoading2 = false;
  SliderController _sliderController = SliderController();
  CategoryController _categoryController = CategoryController();
  ProductController _productController = ProductController();

  var items = [];
  List<CategoryModel> _categoryList = <CategoryModel>[];
  List<ProductModel> _productList = <ProductModel>[];
  List<ProductModel> _allproductList = <ProductModel>[];

  _getAllCategories() async {
    setState(() {
      isLoading2 = true;
    });
    _categoryList = [];
    var categories = await _categoryController.getCategories();
    var result = jsonDecode(categories.body);
    if (result != null) {
      result['data'].forEach((category) {
        var model = CategoryModel();
        String imageUrl = category['icon'].toString();
        String img = imageUrl.substring(21, imageUrl.length);
        model.id = category['id'];
        model.name = category['name'];
        model.icon = baseUrl + img;
        setState(() {
          _categoryList.add(model);
        });
      });
    }
    setState(() {
      isLoading2 = false;
    });
  }

  _getAllHotProducts() async {
    var products = await _productController.getHotProduct();
    var result = jsonDecode(products.body);
    if (result != null) {
      result['data'].forEach((product) {
        var model = ProductModel();
        String imageUrl = product['photo'].toString();
        String img = imageUrl.substring(21, imageUrl.length);
        model.id = product['id'];
        model.name = product['name'];
        model.price = product['price'].toDouble();
        model.discount = product['discount'].toDouble();
        model.photo = baseUrl + img;
        setState(() {
          _productList.add(model);
        });
      });
    }
  }

  _getAllProducts() async {
    var products = await _productController.getProduct();
    var result = jsonDecode(products.body);
    if (result != null) {
      result['data'].forEach((product) {
        var model = ProductModel();
        String imageUrl = product['photo'].toString();
        String img = imageUrl.substring(21, imageUrl.length);
        model.id = product['id'];
        model.name = product['name'];
        model.price = product['price'].toDouble();
        model.discount = product['discount'].toDouble();
        model.photo = baseUrl + img;
        setState(() {
          _allproductList.add(model);
        });
      });
    }
  }

  _getAllSliders() async {
    setState(() {
      isLoading = true;
    });
    var sliders = await _sliderController.getSliders();
    var result = jsonDecode(sliders.body);
    if (result != null) {
      result['data'].forEach((slider) {
        String imageUrl = slider['image'].toString();
        String img = imageUrl.substring(21, imageUrl.length);
        String image = baseUrl + img;

        setState(() {
          items.add(NetworkImage(image));
        });
      });
    }
    setState(() {
      isLoading = false;
    });
    //  print(result);
  }

  @override
  void initState() {
    super.initState();
    _getAllCategories();
    _getAllSliders();
    _getAllHotProducts();
    _getAllProducts();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: ListView(
          shrinkWrap: true,
          scrollDirection: Axis.vertical,
          children: [
            CarouselSlider(items, isLoading),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                'Explore Categories',
                style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
              ),
            ),
            isLoading2
                ? Container(
                    height: 110.0,
                    child: Shimmer.fromColors(
                      baseColor: Colors.grey,
                      highlightColor: Colors.white,
                      child: ListView.builder(
                        itemBuilder: (context, index) {
                          return Container(
                            height: 100,
                            width: 100,
                          );
                        },
                        itemCount: 10,
                      ),
                    ),
                  )
                : HomeProductCategories(categoryList: _categoryList),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                'Hot Products',
                style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
              ),
            ),
            HomeHotProducts(productList: _productList),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                'Hot Products',
                style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
              ),
            ),
            Container(
              height: MediaQuery.of(context).size.height - 100,
              child: GridView.builder(
                physics: NeverScrollableScrollPhysics(),
                padding: EdgeInsets.only(left: 8, right: 8),
                gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
                    maxCrossAxisExtent: 200,
                    childAspectRatio: 2.5 / 3,
                    crossAxisSpacing: 5,
                    mainAxisSpacing: 5),
                itemBuilder: (context, index) => GestureDetector(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => ProductScreen(
                                  productModel: _allproductList[index],
                                )));
                  },
                  child: Card(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(5),
                              topRight: Radius.circular(5)),
                          child: Image.network(
                            _allproductList[index].photo,
                            width: double.infinity,
                            fit: BoxFit.cover,
                            height: 165,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            _allproductList[index].name,
                            overflow: TextOverflow.ellipsis,
                          ),
                        )
                      ],
                    ),
                  ),
                ),
                itemCount: _allproductList.length,
              ),
            )
          ],
        ),
      ),
    );
  }
}
