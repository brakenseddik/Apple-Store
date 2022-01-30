import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:planety_app/components/home_hot_products.dart';
import 'package:planety_app/components/home_product_categories.dart';
import 'package:planety_app/components/homepage_products.dart';
import 'package:planety_app/controllers/category_controller.dart';
import 'package:planety_app/controllers/home_controller.dart';
import 'package:planety_app/controllers/product_controller.dart';
import 'package:shimmer/shimmer.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final CategoryController categoryController = Get.find();
  final ProductController productController = Get.find();
  final HomeController homeController = Get.find();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Obx(() {
        return ListView(
          physics: ScrollPhysics(),
          shrinkWrap: true,
          scrollDirection: Axis.vertical,
          children: [
            //  CarouselSlider(items, isLoading),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                'Explore Categories',
                style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
              ),
            ),
            categoryController.loading.isTrue
                ? Center(child: CircularProgressIndicator())
                : HomeProductCategories(
                    categoryList: categoryController.categories),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                'Hot Products',
                style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
              ),
            ),
            HomeHotProducts(
              productList: productController.productList,
              loading: productController.loading.value,
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                'All Products',
                style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
              ),
            ),
            Container(
              height: MediaQuery.of(context).size.height - 100,
              child: productController.loadingTwo.isTrue
                  ? allProductsLoading()
                  : allProductsSection(productController: productController),
            )
          ],
        );
      }),
    );
  }
}

class allProductsLoading extends StatelessWidget {
  const allProductsLoading({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      padding: EdgeInsets.only(left: 8, right: 8),
      gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
          maxCrossAxisExtent: 200,
          childAspectRatio: 2.5 / 3,
          crossAxisSpacing: 5,
          mainAxisSpacing: 5),
      itemCount: 10,
      itemBuilder: (context, index) {
        return Shimmer.fromColors(
          baseColor: Colors.grey.shade300,
          highlightColor: Colors.grey.shade100,
          child: Container(
              margin: EdgeInsets.all(8),
              width: 160.0,
              height: 160.0,
              color: Colors.grey.shade300),
        );
      },
    );
  }
}
