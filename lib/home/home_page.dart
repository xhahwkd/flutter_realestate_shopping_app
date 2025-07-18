import 'package:flutter/material.dart';
import 'package:flutter_realestate_shopping_app/filtering/filtering_page.dart';
import 'package:flutter_realestate_shopping_app/home/widget/login_type.dart';
import 'package:flutter_realestate_shopping_app/like_list/like_list_page.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Column(
            children: [
              Spacer(),
              Text(
                "임박세일 홈즈!",
                style: TextStyle(
                  fontFamily: 'parkdahyun',
                  fontSize: 40,
                  fontWeight: FontWeight.normal,
                ),
              ),
              Spacer(),
              Text("로그인 유형을 선택해 주세요.", style: TextStyle(fontSize: 20)),
              SizedBox(height: 50),
              GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => FilteringPage()),
                  );
                },
                child: LoginType(loginType: "구매자", emoji: "🧑‍💻"),
              ),
              SizedBox(height: 40),
              GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => LikeListPage()),
                  );
                },
                child: LoginType(loginType: "판매자", emoji: "💰"),
              ),
              Spacer(),
            ],
          ),
        ),
      ),
    );
  }
}
