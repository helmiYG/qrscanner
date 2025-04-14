import 'package:flutter/material.dart';

// ignore: must_be_immutable
class Button extends StatelessWidget {
  String title;
  Color? color = Colors.white;
  bool selected;
  Function onClick;
  double? width;
  Button(
      {super.key,
      required this.title,
      this.color,
      this.width,
      required this.selected,
      required this.onClick});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        onClick.call();
      },
      child: Container(
        padding: EdgeInsets.all(13),
        width: width ?? MediaQuery.of(context).size.width * 0.38,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(5)),
            gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  Color(selected ? 0xFFFDB623 : 0xFF333333),
                  Color(selected ? 0xFFFDB623 : 0xFF333333).withOpacity(0.3),
                ])
            // color: Color(0xFF333333),
            ),
        child: Center(
            child: Text(
          title,
          style: TextStyle(color: color, fontSize: 17, fontFamily: 'Itim'),
        )),
      ),
    );
  }
}
