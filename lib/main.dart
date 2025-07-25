import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'models/like_controller.dart';
import 'models/product_model.dart';
import 'package:flutter_realestate_shopping_app/home/home_page.dart';

List<Product> globalProductList = []; //전역 리스트
void main() {
  Get.put(LikeController());
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        appBarTheme: const AppBarTheme(
          backgroundColor: Color.fromRGBO(255, 252, 246, 1),
          centerTitle: true,
          titleTextStyle: TextStyle(
            fontFamily: 'parkdahyun',
            fontWeight: FontWeight.normal,
            fontSize: 30,
            color: Colors.black,
          ),
        ),
        textTheme: const TextTheme(
          bodyLarge: TextStyle(fontFamily: 'NotoSansKR-Bold', fontSize: 20),
          bodyMedium: TextStyle(
            fontFamily: 'NotoSansKR-Regular',
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
          bodySmall: TextStyle(fontFamily: 'NotoSansKR-Light', fontSize: 20),
        ),
        scaffoldBackgroundColor: Color.fromRGBO(255, 252, 246, 1),
        colorScheme: ColorScheme.fromSeed(
          seedColor: Color.fromRGBO(191, 49, 49, 1.0),
        ),
      ),
      home: HomePage(),
    );
  }
}
