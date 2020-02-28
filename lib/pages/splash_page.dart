import 'package:flutter/material.dart';

class SplashPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: <Widget>[
          Container(
            decoration: BoxDecoration(color: Color(0xFFE3EBEE)),
          ),
          Center(
            child: RichText(
              text: TextSpan(children: [
                TextSpan(
                    text: "A",
                    style: TextStyle(
                        fontFamily: 'Inter',
                        fontSize: 80,
                        fontWeight: FontWeight.bold,
                        color: Colors.black)),
                TextSpan(
                    text: ".",
                    style: TextStyle(
                        fontFamily: 'Inter',
                        fontSize: 100,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF07877D))),
              ]),
            ),
          ),
        ],
      ),
    );
  }
}
