import 'package:flutter/material.dart';

class HeaderContainer extends StatelessWidget {
  final List<Widget> children;

  const HeaderContainer({super.key, required this.children});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        width: MediaQuery.of(context).size.width * 0.8,
        height: 50,
        padding: EdgeInsets.fromLTRB(20, 10, 20, 10),
        decoration: BoxDecoration(
            boxShadow: [
              BoxShadow(
                spreadRadius: 1,
                blurRadius: 6,
                offset: Offset(1, 3), // changes position of shadow
              ),
            ],
            color: Color(0xff414140),
            borderRadius: BorderRadius.all(Radius.circular(10))),
        child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: children),
      ),
    );
    ;
  }
}
