import 'package:flutter/material.dart';
import 'package:qr_barcode_scanner/page/home_page/widgets/button.dart';
import 'package:qr_barcode_scanner/page/home_page/widgets/text.dart';

class GenerateModel {
  String label;
  IconData icon;

  GenerateModel({required this.label, required this.icon});
}

// ignore: must_be_immutable
class GenerateQR extends StatefulWidget {
  GenerateModel data;

  GenerateQR({super.key, required this.data});

  @override
  State<GenerateQR> createState() => _GenerateQRState();
}

class _GenerateQRState extends State<GenerateQR> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF6c6c6b),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            HeaderResult(context),
            CardResult(context),
          ],
        ),
      ),
    );
  }

  Widget HeaderResult(BuildContext context) {
    return Center(
      child: Container(
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
                            blurRadius: 7,
                            spreadRadius: 2,
                            offset: Offset(0, 3))
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
            SizedBox(
              width: 30,
            ),
            TextCustom(
              color: Colors.white,
              title: 'Generate',
              fontSize: 27,
            )
          ],
        ),
      ),
    );
  }

  Widget CardResult(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(40),
      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
      decoration: BoxDecoration(
        border: Border.symmetric(
            horizontal: BorderSide(width: 2, color: Color(0xFFFDB623))),
        borderRadius: BorderRadius.circular(10),
        color: Color(0XFF3C3C3C),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            padding: EdgeInsets.all(5),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: Color(0xFFFDB623), width: 2)),
            child: Icon(
              widget.data.icon,
              color: Color(0xFFFDB623),
              size: 40,
            ),
          ), // Ikon warna putih
          SizedBox(height: 20),
          TextField(
            style: TextStyle(color: Colors.white),
            decoration: InputDecoration(
              hintText: 'type your ${widget.data.label.toLowerCase()} data',
              hintStyle: TextStyle(color: Colors.white70),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: BorderSide(
                    color: Colors.grey, width: 2), // Border ungu saat fokus
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: BorderSide(
                    color: Colors.grey), // Border abu-abu saat tidak fokus
              ),
            ),
          ),
          SizedBox(height: 20),
          Button(title: 'Generate QR', selected: true, onClick: () {}),
        ],
      ),
    );
  }
}
