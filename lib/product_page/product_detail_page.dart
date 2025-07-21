import 'package:flutter/material.dart';
import 'package:flutter_realestate_shopping_app/like_list/like_list_page.dart';
import '../models/product_model.dart';
import 'package:get/get.dart';
import '../models/like_controller.dart';

class ProductDetailPage extends StatelessWidget {
  final Product product;
  const ProductDetailPage({super.key, required this.product});

  String formatPrice(int price) {
    if (price == 0) return '사기입니다.';
    return price.toString().replaceAllMapped(
          RegExp(r'\B(?=(\d{3})+(?!\d))'),
          (match) => ',',
        ) +
        ' 원';
  }

  @override
  Widget build(BuildContext context) {
    final LikeController likeController = Get.find<LikeController>();

    return Scaffold(
      appBar: AppBar(title: const Text('상품상세페이지')),

      // 본문 영역
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // 상품등록페이지 이미지 대신 텍스트 박스 가져옴
            Container(
              height: 210,
              alignment: Alignment.center,
              color: Colors.grey[300],
              child: Text(
                product.imagePath,
                style: const TextStyle(fontSize: 16),
              ),
            ),
            const SizedBox(height: 20),
            // 상품정보
            Container(
              height: 400,
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(20),
              ),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('매물 종류: ${product.type}'),
                    const SizedBox(height: 8),
                    Text(
                      '상품명: ${product.name}',
                      style: const TextStyle(fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      '가격: ${formatPrice(product.price)}',
                      style: const TextStyle(color: Colors.red),
                    ),
                    const SizedBox(height: 8),
                    Text(product.description),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),

      // 하단 구매 + 하트 버튼 영역
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.fromLTRB(20, 0, 20, 20),
        child: Row(
          children: [
            Expanded(
              child: SizedBox(
                height: 50,
                child: ElevatedButton(
                  onPressed: () {
                    showDialog(
                      context: context,
                      builder: (context) => AlertDialog(
                        content: Text('${product.name} 구매하시겠습니까?'),
                        actions: [
                          TextButton(
                            onPressed: () => Navigator.pop(context),
                            child: const Text('취소'),
                          ),
                          TextButton(
                            onPressed: () {
                              Navigator.pop(context);
                              showDialog(
                                context: context,
                                builder: (context) => AlertDialog(
                                  content: const Text('구매 완료'),
                                  actions: [
                                    TextButton(
                                      onPressed: () => Navigator.pop(context),
                                      child: const Text('확인'),
                                    ),
                                  ],
                                ),
                              );
                            },
                            child: const Text('확인'),
                          ),
                        ],
                      ),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.red,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                  ),
                  child: const Text(
                    '구매하기',
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(width: 8),
            Obx(() {
              final isLiked = likeController.isLiked(product);
              return GestureDetector(
                onTap: () {
                  likeController.toggleLike(product);
                },
                child: Text(
                  isLiked ? '❤️' : '🤍',
                  style: const TextStyle(fontSize: 28),
                ),
              );
            }),
          ],
        ),
      ),
    );
  }
}
