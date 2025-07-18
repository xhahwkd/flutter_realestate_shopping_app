import 'package:flutter/material.dart';

class RedButton extends StatelessWidget {
  final Widget landingPage;
  final String title;

  const RedButton({required this.landingPage, required this.title, super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(30),
      child: Row(
        children: [
          Expanded(
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Color.fromRGBO(191, 49, 49, 1.0),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16), // 둥근 모서리
                ),
                elevation: 5,
                shadowColor: Colors.black, // 그림자 색상
                padding: EdgeInsets.symmetric(horizontal: 32, vertical: 16),
              ),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => landingPage),
                );
              },
              child: Text(
                title,
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
    );
  }
}
