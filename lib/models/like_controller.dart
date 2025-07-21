import 'package:get/get.dart';
import '../models/product_model.dart';

class LikeController extends GetxController {
  var likedProducts = <Product>[].obs;
  // 여러 개를 체크하는 Map 대신, 선택된 상품 하나만 저장합니다.
  var selectedProduct = Rx<Product?>(null);

  bool isLiked(Product product) => likedProducts.contains(product);

  void toggleLike(Product product) {
    if (isLiked(product)) {
      // 찜 목록에서 삭제될 때, 선택된 상태도 해제합니다.
      if (selectedProduct.value == product) {
        selectedProduct.value = null;
      }
      likedProducts.remove(product);
    } else {
      likedProducts.add(product);
    }
  }

  // 상품을 선택/해제하는 함수입니다.
  void selectProduct(Product product) {
    // 이미 선택된 상품을 다시 누르면 선택 해제
    if (selectedProduct.value == product) {
      selectedProduct.value = null;
    } else {
      // 다른 상품을 선택하면 그 상품으로 변경
      selectedProduct.value = product;
    }
  }

  // 선택된 상품의 가격을 가져오는 getter
  int get selectedProductPrice {
    return selectedProduct.value?.price ?? 0;
  }

  // 상품이 선택되었는지 여부를 확인하는 getter
  bool get isProductSelected => selectedProduct.value != null;
}
