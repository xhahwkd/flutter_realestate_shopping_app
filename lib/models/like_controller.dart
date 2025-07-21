import 'package:get/get.dart';
import '../models/product_model.dart';

class LikeController extends GetxController {
  var likedProducts = <Product>[].obs;
  var checkedMap = <Product, bool>{}.obs;

  bool isLiked(Product product) => likedProducts.contains(product);

  void toggleLike(Product product) {
    if (isLiked(product)) {
      likedProducts.remove(product);
      checkedMap.remove(product);
    } else {
      likedProducts.add(product);
      checkedMap[product] = false;
    }
    update();
  }

  void toggleCheck(Product product) {
    checkedMap[product] = !(checkedMap[product] ?? false);
    update();
  }

  int get checkedTotalPrice {
    int sum = 0;
    checkedMap.forEach((product, checked) {
      if (checked) sum += product.price;
    });
    return sum;
  }

  bool get hasChecked => checkedMap.values.any((v) => v);
}
