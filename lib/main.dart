import 'package:flutter/material.dart';
import 'pages/product_list_page.dart';
import 'models/product_model.dart';
import 'package:flutter_realestate_shopping_app/home/home_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
/*feature/register
      title: '집 임박세일',
      theme: ThemeData(
        scaffoldBackgroundColor: const Color(0xFFF5F5F5),
        fontFamily: 'Pretendard', // 폰트 asset 등록 시
        appBarTheme: const AppBarTheme(
          backgroundColor: Colors.white,
          foregroundColor: Colors.black,
          elevation: 1,
        ),
        useMaterial3: true,
      ),
      home: ProductListHome(), // 상태 관리 포함된 홈 위젯
    );
  }
}

// 홈에서 상태관리 포함된 상품 리스트
class ProductListHome extends StatefulWidget {
  const ProductListHome({super.key});

  @override
  State<ProductListHome> createState() => _ProductListHomeState();
}

class _ProductListHomeState extends State<ProductListHome> {
  final List<Product> _products = [];

  void _addProduct(Product product) {
    setState(() {
      _products.add(product);
    });
  }

  @override
  Widget build(BuildContext context) {
    return ProductListPage(productList: _products, onProductAdded: _addProduct);
*/
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
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      ),
      home: HomePage(),
    );
  }
}
