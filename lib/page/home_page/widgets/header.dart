import 'package:flutter/material.dart';
import 'package:qr_barcode_scanner/page/module/header_container.dart';
import 'package:qr_barcode_scanner/page/settings_app/settings_app.dart';

class Header extends StatelessWidget {
  String menu;
  Header({super.key, required this.menu});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        width: MediaQuery.of(context).size.width * 0.8,
        child:
            Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
          Text(
            menu,
            style: TextStyle(
                fontSize: 27, fontFamily: 'Itim', color: Colors.white),
          ),
          GestureDetector(
            onTap: () => Navigator.of(context)
                .push(MaterialPageRoute(builder: (context) => SettingsApp())),
            child: Container(
              padding: EdgeInsets.all(10),
              decoration: BoxDecoration(
                  boxShadow: [
                    BoxShadow(
                        blurRadius: 7, spreadRadius: 2, offset: Offset(0, 3))
                  ],
                  borderRadius: BorderRadius.circular(5),
                  color: Color(0XFF333333)),
              child: Center(
                child: Image.asset(
                  'assets/images/burger_menu.png',
                  height: 24,
                ),
              ),
            ),
          )
        ]),
      ),
    );
  }
}
