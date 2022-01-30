// @dart=2.0
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:planety_app/controllers/cart_controller.dart';
import 'package:planety_app/controllers/category_controller.dart';
import 'package:planety_app/controllers/home_controller.dart';
import 'package:planety_app/controllers/product_controller.dart';
import 'package:planety_app/views/main_screen.dart';

void main() async {
  // WidgetsFlutterBinding.ensureInitialized();
  // SystemChrome.setEnabledSystemUIOverlays([]);
  // SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
  //   statusBarColor: Colors.transparent, // transparent status bar
  // ));

  WidgetsFlutterBinding.ensureInitialized();

  final categoryController = Get.lazyPut(() => CategoryController());
  final productController = Get.lazyPut(() => ProductController());
  final homeController = Get.lazyPut(() => HomeController());
  Get.lazyPut(() => CartController());

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      home: MainScreen(),
      theme: ThemeData(
          scaffoldBackgroundColor: Colors.white,
          appBarTheme: AppBarTheme(
              centerTitle: true,
              backgroundColor: Colors.white,
              elevation: 0.0,
              titleTextStyle: TextStyle(color: Colors.black),
              actionsIconTheme: IconThemeData(color: Colors.black),
              iconTheme: IconThemeData(color: Colors.black))),
      themeMode: ThemeMode.system,
    );
  }
}
