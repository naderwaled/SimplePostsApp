import 'package:flutter/material.dart';
import 'package:Task/constant.dart';

class TextBox extends StatelessWidget {
  TextBox({@required this.hint});
  final String hint;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 30.0),
      child: TextField(
        decoration: kInputdecoration.copyWith(hintText: hint),
      ),
    );
  }
}
