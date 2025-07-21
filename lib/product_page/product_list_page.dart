import 'package:flutter/material.dart';
import 'package:flutter_realestate_shopping_app/main.dart';
import 'package:flutter_realestate_shopping_app/product_page/product_register_page.dart';
import 'package:flutter_realestate_shopping_app/product_page/widgets/product_card.dart';
import '../models/product_model.dart';

class ProductListPage extends StatefulWidget {
  final List<Product>? productList; // 필터링된 리스트를 받을 수 있도록 nullable 파라미터 추가

  const ProductListPage({super.key, this.productList}); // 생성자에 productList 추가

  @override
  State<ProductListPage> createState() => _ProductListPageState();
}

class _ProductListPageState extends State<ProductListPage> {
  void _addProduct(Product product) {
    setState(() {
      globalProductList.add(product); //전역 리스트에 추가
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('매물 목록')),
      body: globalProductList.isEmpty
          ? const Center(
              child: Text('매물이 존재하지 않습니다.', style: TextStyle(fontSize: 16)),
            )
          : ListView.builder(
              padding: const EdgeInsets.all(16),
              itemCount: globalProductList.length,
              itemBuilder: (context, index) {
                return ProductCard(product: globalProductList[index]);
              },
            ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          final newProduct = await Navigator.push(
            context,
            MaterialPageRoute(builder: (_) => const ProductRegisterPage()),
          );
          if (newProduct != null && newProduct is Product) {
            _addProduct(newProduct);
          }
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
