import 'package:flutter/material.dart';
import 'package:flutter_realestate_shopping_app/main.dart';
import 'package:flutter_realestate_shopping_app/models/product_model.dart';
import 'package:flutter_realestate_shopping_app/product_page/product_list_page.dart';
import 'package:flutter_realestate_shopping_app/filtering/widget/category_dropdown.dart';
import 'package:flutter_realestate_shopping_app/widgets/red_button.dart';

class FilteringPage extends StatefulWidget {
  final String price;
  final String productCategory;
  const FilteringPage({Key? key, this.price = '', this.productCategory = ''})
    : super(key: key);

  @override
  State<FilteringPage> createState() => _FilteringPageState();
}

class _FilteringPageState extends State<FilteringPage> {
  String selectedPrice = "전체";
  String selectedCategory = "전체";

  List<Product> getFilteredList() {
    // globalProductList 기준으로 필터링
    return globalProductList.where((product) {
      final matchesPrice =
          selectedPrice == "전체" || _matchPrice(product.price, selectedPrice);
      final matchesCategory =
          selectedCategory == "전체" || product.type == selectedCategory;
      return matchesPrice && matchesCategory;
    }).toList();
  }

  bool _matchPrice(int price, String selected) {
    switch (selected) {
      case "1억 미만":
        return price < 100000000;
      case "1억 ~ 5억 미만":
        return price >= 100000000 && price < 500000000;
      case "5억 ~ 10억 미만":
        return price >= 500000000 && price < 1000000000;
      case "10억 이상":
        return price >= 1000000000;
      default:
        return true;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(leading: BackButton(), title: Text("홈")),
      body: Center(
        child: Column(
          children: [
            Spacer(),
            Text("어떤 매물을 찾고 계신가요?"),
            Spacer(),
            CategoryDropdown(
              categories: [
                "전체",
                "1억 미만",
                "1억 ~ 5억 미만",
                "5억 ~ 10억 미만",
                "10억 이상",
              ],
              onCategorySelected: (category) {
                setState(() {
                  selectedPrice = category; //선택된 가격 저장
                });
                // price = category; // final로 변경되어 할당 불가, 실제 필터링 로직 필요시 상태관리 필요
              },
              filteringCategory: "가격",
            ),
            const SizedBox(height: 50),
            CategoryDropdown(
              categories: ["전체", "아파트", "빌라", "오피스텔", "기타"],
              onCategorySelected: (category) {
                setState(() {
                  selectedCategory = category; //선택된 매물 유형 저장
                });

                // productCategory = category; // final로 변경되어 할당 불가, 실제 필터링 로직 필요시 상태관리 필요
              },
              filteringCategory: "매물 유형",
            ),
            const Spacer(),
            RedButton(
              title: "검색하기",
              landingPage: ProductListPage(productList: getFilteredList()),
            ),
            const Spacer(),
          ],
        ),
      ),
    );
  }
}
