import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_realestate_shopping_app/like_list/widget/like_item_box.dart';
import 'package:flutter_realestate_shopping_app/models/like_controller.dart';
import 'package:flutter_realestate_shopping_app/product_page/product_list_page.dart';
import 'package:get/get.dart';

class LikeListPage extends StatelessWidget {
  LikeListPage({Key? key}) : super(key: key);

  final LikeController likeController = Get.find<LikeController>();

  void _showPurchaseDialog(BuildContext context) {
    final product = likeController.selectedProduct.value;
    if (product == null) return;

    showDialog(
      context: context,
      builder: (context) => CupertinoAlertDialog(
        title: const Text("구매 확인"),
        content: Text("${product.name}을/를 정말 구매하시겠습니까?"),
        actions: [
          CupertinoDialogAction(
            child: const Text("취소"),
            onPressed: () => Navigator.of(context).pop(),
          ),
          CupertinoDialogAction(
            child: const Text("확인"),
            isDefaultAction: true,
            onPressed: () {
              // 1. "구매 확인" 팝업을 먼저 닫습니다.
              Navigator.of(context).pop();

              // 2. 그 다음에 "구매 완료" 팝업을 띄웁니다.
              showDialog(
                context: context,
                builder: (context) => CupertinoAlertDialog(
                  title: const Text('구매 완료'),
                  actions: [
                    CupertinoDialogAction(
                      isDefaultAction: true,
                      child: const Text('확인'),
                      onPressed: () {
                        // "구매 완료" 팝업을 닫고,
                        Navigator.of(context).pop();
                        // "찜 목록 페이지"도 닫아 매물 목록으로 돌아갑니다.
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
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("찜 목록")),
      body: Stack(
        children: [
          Column(
            children: [
              // 찜 목록 리스트
              Expanded(
                child: Obx(() {
                  final likeList = likeController.likedProducts;
                  if (likeList.isEmpty) {
                    return const Center(child: Text('찜한 상품이 없습니다.'));
                  }
                  return ListView.builder(
                    itemCount: likeList.length,
                    itemBuilder: (context, index) {
                      final product = likeList[index];
                      return LikeItemBox(product: product);
                    },
                  );
                }),
              ),
              // 하단 구매하기 버튼
              Padding(
                padding: const EdgeInsets.all(30),
                child: Obx(
                  () => Row(
                    children: [
                      Expanded(
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: const Color.fromRGBO(
                              191,
                              49,
                              49,
                              1.0,
                            ),
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
                          onPressed: likeController.isProductSelected
                              ? () => _showPurchaseDialog(context)
                              : null,
                          child: const Text(
                            "구매하기",
                            style: TextStyle(
                              fontSize: 25,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
          // 오른쪽 하단에 선택한 매물 가격 표시
          Positioned(
            right: 15,
            bottom: 100, // 구매 버튼 위에 위치
            child: Obx(() {
              final price = likeController.selectedProductPrice;
              return price > 0
                  ? Padding(
                      padding: const EdgeInsets.all(15),
                      child: Container(
                        child: Text(
                          "가격: " + _formatPrice(price),
                          style: const TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: Color.fromRGBO(191, 49, 49, 1.0),
                          ),
                        ),
                      ),
                    )
                  : const SizedBox.shrink();
            }),
          ),
        ],
      ),
    );
  }

  // 3자리마다 쉼표 함수
  String _formatPrice(int price) {
    return price.toString().replaceAllMapped(
          RegExp(r'\B(?=(\d{3})+(?!\d))'),
          (match) => ',',
        ) +
        '원';
  }
}
