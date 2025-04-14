import 'package:flutter/material.dart';

// ignore: must_be_immutable
class TextCustom extends StatelessWidget {
  String title;
  Color? color = Colors.white;
  double? fontSize = 17;
  TextCustom({super.key, required this.title, this.color, this.fontSize});

  @override
  Widget build(BuildContext context) {
    return Text(title,
        style: TextStyle(color: color, fontSize: fontSize, fontFamily: 'Itim'));
  }
}
