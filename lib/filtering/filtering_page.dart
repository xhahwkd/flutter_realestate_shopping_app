import 'package:flutter/material.dart';
import 'package:flutter_realestate_shopping_app/red_button.dart';
import 'package:flutter_realestate_shopping_app/filtering/widget/category_dropdown.dart';
import 'package:flutter_realestate_shopping_app/product_list/product_list_page.dart';

class FilteringPage extends StatelessWidget {
  get center => null;
  late String price;
  late String productCategory;

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
                price = category;
              },
              filteringCategory: "가격",
            ),
            SizedBox(height: 50),
            CategoryDropdown(
              categories: ["전체", "아파트", "빌라", "오피스텔"],
              onCategorySelected: (category) {
                productCategory = category;
              },
              filteringCategory: "매물 유형",
            ),
            Spacer(),
            RedButton(landingPage: ProductListPage(), title: "검색하기"),
            Spacer(),
          ],
        ),
      ),
    );
  }
}
