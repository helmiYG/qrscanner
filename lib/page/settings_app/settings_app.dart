import 'package:flutter/material.dart';
import 'package:qr_barcode_scanner/page/home_page/widgets/text.dart';

class SettingsApp extends StatefulWidget {
  const SettingsApp({super.key});

  @override
  State<SettingsApp> createState() => _SettingsAppState();
}

class _SettingsAppState extends State<SettingsApp> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF6c6c6b),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            HeaderResult(context),
            SettingMenu(context),
          ],
        ),
      ),
    );
  }

  Widget HeaderResult(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 40),
      padding: EdgeInsets.fromLTRB(20, 10, 20, 10),
      child: Row(
        children: [
          GestureDetector(
              onTap: () => Navigator.of(context).pop(),
              child: Container(
                height: 40,
                width: 40,
                // padding: EdgeInsets.all(10),
                decoration: BoxDecoration(
                    boxShadow: [
                      BoxShadow(
                          blurRadius: 7, spreadRadius: 2, offset: Offset(0, 3))
                    ],
                    borderRadius: BorderRadius.circular(5),
                    color: Color(0XFF333333)),
                child: Center(
                  child: Image.asset(
                    'assets/images/arrow_back.png',
                    height: 24,
                  ),
                ),
              )),
        ],
      ),
    );
  }

  Widget SettingMenu(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 20),
      padding: EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            margin: EdgeInsets.only(bottom: 25),
            child: TextCustom(
              title: 'Settings',
              fontSize: 26,
              color: Color(0xFFFDB623),
            ),
          ),
          CardSettings(context,
              icon: Icons.vibration,
              title: 'Vibrate',
              desc: 'vibrate when scan is done',
              isToogle: true),
          CardSettings(context,
              icon: Icons.notifications,
              title: 'Beep',
              desc: 'beep when scan is done',
              isToogle: true)
        ],
      ),
    );
  }

  Widget CardSettings(BuildContext context,
      {required IconData icon,
      required String title,
      required String desc,
      required bool isToogle}) {
    return Container(
      margin: EdgeInsets.only(bottom: 25),
      decoration: BoxDecoration(
          color: Color(0XFF333333),
          borderRadius: BorderRadius.circular(10),
          boxShadow: [
            BoxShadow(blurRadius: 7, spreadRadius: 2, offset: Offset(0, 3))
          ]),
      padding: EdgeInsets.all(10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(
              child: Row(
            children: [
              Icon(
                icon,
                color: Color(0xFFFDB623),
              ),
              SizedBox(
                width: 8,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  TextCustom(
                    fontSize: 16,
                    title: title,
                    color: Color(0xffE2E2E2),
                  ),
                  TextCustom(
                    fontSize: 14,
                    title: desc,
                    color: Color(0xffE2E2E2),
                  )
                ],
              ),
            ],
          )),
          isToogle
              ? Switch(
                  value: true,
                  onChanged: (bool) {},
                  activeColor: Color(0xFFFDB623),
                )
              : SizedBox()
        ],
      ),
    );
  }
}
