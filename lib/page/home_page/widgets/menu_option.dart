import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class MenuOption extends StatelessWidget {
  final Function(String) onClick;
  final String menuName;
  final String asset;

  const MenuOption(
      {super.key,
      required this.onClick,
      required this.menuName,
      required this.asset});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: () {
          onClick(menuName);
        },
        child: Column(
          children: [
            Image.asset(
              asset,
              height: 30,
            ),
            Text(
              menuName,
              textAlign: TextAlign.center,
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 14,
                  fontStyle: FontStyle.normal,
                  fontFamily: 'Itim'),
            )
          ],
        ));
  }
}
