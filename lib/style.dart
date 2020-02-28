import 'package:flutter/material.dart';

class AppSwatch {
  static const Color backgroundGreen = Color(0xFFE3EBEE);
  static const Color foregroundGreen = Color(0xFF07877D);
}

class AppTextStyle {
  static const TextStyle title =
      TextStyle(fontFamily: 'Inter', fontSize: 40, fontWeight: FontWeight.bold);

  static const TextStyle subtitle =
      TextStyle(fontFamily: 'Inter', fontSize: 24, fontWeight: FontWeight.bold);

  static const TextStyle paragraph_bold =
      TextStyle(fontFamily: 'Inter', fontSize: 16, fontWeight: FontWeight.bold);

  static const TextStyle paragraph = TextStyle(
    fontFamily: 'Inter',
    fontSize: 16,
  );
}


ThemeData myTheme = ThemeData(
    fontFamily: 'Inter',
    // tabBarTheme: TabBarTheme(
    //   indicator: UnderlineTabIndicator(
    //       borderSide: BorderSide(color: AppSwatch.foregroundGreen)),
    // ),
    dividerColor: Colors.transparent,
    );
