import 'package:flutter/material.dart';
import 'package:qr_barcode_scanner/page/home_page/widgets/history_qr.dart';
import 'package:qr_barcode_scanner/page/home_page/widgets/text.dart';
import 'package:flutter/services.dart';

// ignore: must_be_immutable
class HistoryResult extends StatefulWidget {
  HistoryDataModel data;
  HistoryResult({super.key, required this.data});

  @override
  State<HistoryResult> createState() => _HistoryResultState();
}

class _HistoryResultState extends State<HistoryResult> {
  void onTapCopy(String text) {
    Clipboard.setData(ClipboardData(text: text)).then((_) {
      ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Copied to your clipboard !')));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF6c6c6b),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          HeaderResult(context),
          CardResult(context),
          FooterButton(context)
        ],
      ),
    );
  }

  Widget FooterButton(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        GestureDetector(
            onTap: () => onTapCopy(widget.data.title),
            child: Container(
              height: 50,
              width: 50,
              // padding: EdgeInsets.all(10),
              decoration: BoxDecoration(
                  boxShadow: [
                    BoxShadow(
                        blurRadius: 5, spreadRadius: 1, offset: Offset(0, 3))
                  ],
                  borderRadius: BorderRadius.circular(5),
                  color: Color(0xFFFDB623)),
              child: Center(
                child: Icon(Icons.share),
              ),
            )),
        SizedBox(
          width: 30,
        ),
        GestureDetector(
            onTap: () => onTapCopy(widget.data.title),
            child: Container(
              height: 50,
              width: 50,
              decoration: BoxDecoration(
                  boxShadow: [
                    BoxShadow(
                        blurRadius: 5, spreadRadius: 1, offset: Offset(0, 3))
                  ],
                  borderRadius: BorderRadius.circular(5),
                  color: Color(0xFFFDB623)),
              child: Center(
                child: Icon(Icons.copy),
              ),
            )),
      ],
    );
  }

  Widget CardResult(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(40),
      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(5), color: Color(0XFF3C3C3C)),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: EdgeInsets.all(5),
                margin: EdgeInsets.only(right: 10),
                color: Colors.amber,
                child: Center(
                  child: Image.asset(
                    'assets/images/qr_scan_float.png',
                    height: 40,
                    width: 35,
                  ),
                ),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  TextCustom(
                    title: widget.data.title,
                    fontSize: 22,
                    color: Colors.white,
                  ),
                  TextCustom(
                    title: widget.data.date,
                    color: Colors.white,
                    fontSize: 13,
                  ),
                ],
              )
            ],
          ),
          Container(
            margin: EdgeInsets.symmetric(vertical: 10),
            decoration: BoxDecoration(
                border: Border.all(color: Colors.white, width: 0.1)),
          ),
          TextCustom(
            title: widget.data.data,
            color: Colors.white,
          ),
          Center(
            child: Container(
              margin: EdgeInsets.only(top: 5),
              child: TextCustom(
                title: 'show QR code',
                color: Colors.amber,
              ),
            ),
          ),
        ],
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
              title: 'Result',
              fontSize: 27,
            )
          ],
        ),
      ),
    );
  }
}
