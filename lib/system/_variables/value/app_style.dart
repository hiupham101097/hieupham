import 'package:flutter/material.dart';

class AppStyle {
  static var colors = [
    [
      const Color(0xFFD1F4F4),
      const Color(0xFF95D4D4),
      const Color(0xFF85E1E1),
      const Color(0xFF78DCB0),
      const Color(0xFF30C8C7),
      const Color(0xFF22C9C8),
      const Color(0xFF1EC8C8),
    ],
    [
      const Color(0xFFFAFEFE),
      const Color(0xFFF8F9FC),
      const Color(0xFFF5F6FA),
      const Color(0xFFD4E2E2),
      const Color(0xFFD4DDE3),
      const Color(0xFF9FA4AE),
      const Color(0xFF8D9EA4),
      const Color(0xFF4B4D5A),
    ],
    [
      const Color(0xFF46A7FA),
      const Color(0xFFEDF79D),
      const Color(0xFFD9D09C),
      const Color(0xFFE12330),
      const Color(0xFF217EBD),
      const Color(0xFFd1049a),
      const Color(0xFF1fa104),
    ],
  ];

  static var borders = [
    const BorderSide(
      width: 0.2,
    )
  ];

  static const borderRadiusCicular = BorderRadius.all(Radius.circular(3.0));

  static ThemeData defaultTheme() {
    return ThemeData(
      appBarTheme: AppBarTheme(
        elevation: 0.5,
        color: colors[0][5],
      ),
      // accentColor: Colors.black,
      inputDecorationTheme: InputDecorationTheme(
          labelStyle: TextStyle(
            color: colors[0][0],
          ),
          focusedBorder: UnderlineInputBorder(
            borderSide: borders[0],
          ),
          errorBorder: UnderlineInputBorder(
            borderSide: borders[0],
          ),
          enabledBorder: UnderlineInputBorder(
            borderSide: borders[0],
          ),
          border: UnderlineInputBorder(
            borderSide: borders[0],
          )),
      // textTheme: TextTheme(
      //   button: TextStyle(
      //     fontSize: 18.0,
      //   ),
      //   body1: TextStyle(
      //     fontSize: 18.0,
      //   ),
      // ),
      // buttonTheme: ButtonThemeData(
      //   buttonColor: color3,
      //   padding: EdgeInsets.all(5),
      // ),
    );
  }
}
