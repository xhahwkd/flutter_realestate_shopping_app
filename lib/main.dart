import 'package:flutter/material.dart';
import 'pages/product_list_page.dart';
import 'models/product_model.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
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
  }
}
