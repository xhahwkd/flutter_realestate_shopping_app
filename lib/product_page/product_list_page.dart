import 'package:flutter/material.dart';
import 'package:flutter_realestate_shopping_app/like_list/like_list_page.dart';
import 'package:flutter_realestate_shopping_app/product_page/product_register_page.dart';
import 'package:flutter_realestate_shopping_app/product_page/widgets/product_card.dart';
import '../models/product_model.dart';

class ProductListPage extends StatefulWidget {
  const ProductListPage({super.key});

  @override
  State<ProductListPage> createState() => _ProductListPageState();
}

class _ProductListPageState extends State<ProductListPage> {
  final List<Product> _productList = [];

  void _addProduct(Product product) {
    setState(() {
      _productList.add(product);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('매물 목록')),
      body: _productList.isEmpty
          ? const Center(
              child: Text('매물이 존재하지 않습니다.', style: TextStyle(fontSize: 16)),
            )
          : ListView.builder(
              padding: const EdgeInsets.all(16),
              itemCount: _productList.length,
              itemBuilder: (context, index) {
                return ProductCard(product: _productList[index]);
              },
            ),
      floatingActionButton: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // 하트 버튼 (위)
          FloatingActionButton(
            heroTag: "likeFab",
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => LikeListPage()),
              );
            },
            backgroundColor: Colors.white,
            child: const Icon(Icons.favorite, color: Colors.red),
          ),
          const SizedBox(height: 16), // 버튼 사이 간격
          // + 버튼 (아래)
          FloatingActionButton(
            heroTag: "addFab",
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
        ],
      ),
    );
  }
}
