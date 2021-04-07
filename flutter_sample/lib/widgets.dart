import 'package:flutter/material.dart';

class Widgets {
  Widget button_1(String text) {
    return Container(
      width: 200,
      height: 30,
      child: ElevatedButton(
          style: ElevatedButton.styleFrom(
              primary: Color(0xFF1b8c3a),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(25)))),
          onPressed: () {},
          child: Text(text)),
    );
  }
}
