import 'package:flutter/cupertino.dart';
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
      appBar: AppBar(title: const Text('상세페이지')),

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
                      style: const TextStyle(
                        color: Color.fromRGBO(191, 49, 49, 1.0),
                      ),
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
              child: ElevatedButton(
                onPressed: () {
                  showDialog(
                    context: context,
                    builder: (dialogContext) => CupertinoAlertDialog(
                      title: const Text("구매 확인"),
                      content: Text("${product.name}을/를 구매하시겠습니까?"),
                      actions: [
                        CupertinoDialogAction(
                          child: const Text("취소"),
                          onPressed: () => Navigator.of(dialogContext).pop(),
                        ),
                        CupertinoDialogAction(
                          child: const Text("확인"),
                          isDefaultAction: true,
                          onPressed: () {
                            // 확인 버튼 누르면, 먼저 확인창을 닫고,
                            Navigator.of(dialogContext).pop();
                            // 그 다음에 구매완료 창을 띄웁니다.
                            showDialog(
                              context: context,
                              builder: (context) => CupertinoAlertDialog(
                                title: const Text('구매 완료'),
                                actions: [
                                  CupertinoDialogAction(
                                    isDefaultAction: true,
                                    child: const Text('확인'),
                                    onPressed: () {
                                      // 1. "구매 완료" 팝업을 닫습니다.
                                      Navigator.of(context).pop();
                                      // 2. "상품 상세 페이지"도 닫습니다. (이렇게 하면 매물 목록으로 돌아갑니다)
                                      Navigator.of(context).pop();
                                    },
                                  ),
                                ],
                              ),
                            );
                          },
                        ),
                      ],
                    ),
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color.fromRGBO(191, 49, 49, 1.0),
                  disabledBackgroundColor: Colors.grey,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                  elevation: 5,
                  shadowColor: Colors.black,
                  padding: const EdgeInsets.symmetric(
                    horizontal: 32,
                    vertical: 16,
                  ),
                ),
                child: const Text(
                  '구매하기',
                  style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
            const SizedBox(width: 20),
            Obx(() {
              final isLiked = likeController.isLiked(product);
              return GestureDetector(
                onTap: () {
                  likeController.toggleLike(product);
                },
                child: Text(
                  isLiked ? '❤️' : '🤍',
                  style: const TextStyle(fontSize: 35),
                ),
              );
            }),
          ],
        ),
      ),
    );
  }
}
