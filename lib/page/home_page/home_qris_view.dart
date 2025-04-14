import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:qr_barcode_scanner/page/history_result/history_result.dart';
import 'dart:developer';
import 'package:qr_code_scanner/qr_code_scanner.dart';
import 'package:qr_barcode_scanner/page/home_page/widgets/generate_list.dart';
import 'package:qr_barcode_scanner/page/home_page/widgets/header.dart';
import 'package:qr_barcode_scanner/page/home_page/widgets/history_qr.dart';
import 'package:qr_barcode_scanner/page/home_page/widgets/menu_option.dart';
import 'package:qr_barcode_scanner/page/home_page/widgets/scan_options.dart';

class HomeQRIS extends StatefulWidget {
  const HomeQRIS({super.key});

  @override
  State<HomeQRIS> createState() => _HomeQRISState();
}

class _HomeQRISState extends State<HomeQRIS> {
  QRViewController? controller;
  final GlobalKey qrKey = GlobalKey(debugLabel: 'QR');
  var selectedMenu = 'scan';

  void onClickMenu(menu) {
    setState(() {
      selectedMenu = menu;
    });
  }

  @override
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF6c6c6b),
      body: Stack(
        children: [
          /// Kamera sebagai background
          Positioned.fill(
              child:
                  selectedMenu == 'scan' ? _buildQrView(context) : Container()),

          /// Lapisan UI di atas kamera
          Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                margin: EdgeInsets.only(top: 60),
                child: selectedMenu == 'scan'
                    ? ScanOptions() // ScanOptions ada di atas kamera
                    : Header(menu: selectedMenu),
              ),

              // Tampilkan tampilan lain hanya jika bukan scan
              if (selectedMenu == 'generate')
                GenerateMenu()
              else if (selectedMenu == 'history')
                Expanded(child: HistoryQr()),

              QRMenu(onClick: onClickMenu)
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildQrView(BuildContext context) {
    // For this example we check how width or tall the device is and change the scanArea and overlay accordingly.
    var scanArea = (MediaQuery.of(context).size.width < 400 ||
            MediaQuery.of(context).size.height < 400)
        ? 300.0
        : 400.0;
    // To ensure the Scanner view is properly sizes after rotation
    // we need to listen for Flutter SizeChanged notification and update controller

    return QRView(
      key: qrKey,
      onQRViewCreated: _onQRViewCreated,
      overlay: QrScannerOverlayShape(
          // borderColor: const Color.fromARGB(255, 68, 224, 255),
          // borderRadius: 10,
          // borderLength: 30,
          // borderWidth: 10,
          cutOutSize: scanArea),
      onPermissionSet: (ctrl, p) => _onPermissionSet(context, ctrl, p),
    );
  }

  void _onQRViewCreated(QRViewController controller) {
    print('masuk _onQRViewCreated');
    var lastQrCodeReadDate = DateTime.now();
    setState(() {
      this.controller = controller;
    });
    controller.scannedDataStream.listen((scanData) async {
      print('scannedDataStream listened');
      final dateNow = DateTime.now();
      if (dateNow.difference(lastQrCodeReadDate).inSeconds < 3) return;
      await controller.pauseCamera();
      if (scanData.code != null) {
        print('${scanData.code} dan ${scanData.format}');
        Navigator.of(context).push(MaterialPageRoute(
            builder: (category) => HistoryResult(
                  data: getHistoryData(scanData),
                )));
        // Navigator.of(context).push(MaterialPageRoute(
        //   builder: (context) => ResultView(
        //     code: scanData.code,
        //     format: describeEnum(scanData.format),
        //   ),
        // ));
      }

      // setState(() {
      //   result = scanData;
      // });
    });
  }

  void _onPermissionSet(BuildContext context, QRViewController ctrl, bool p) {
    log('${DateTime.now().toIso8601String()}_onPermissionSet $p');
    if (!p) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('no Permission')),
      );
    }
  }

  HistoryDataModel getHistoryData(Barcode argument) {
    print('== format ${argument.format}');
    print('== code ${argument.code}');
    return HistoryDataModel(
      title: categoryChecker(argument.code.toString()),
      data: argument.code.toString(),
      date: DateTime.now().toString(),
      id: 12345.0,
    );
  }

  String categoryChecker(String data) {
    print('data $data');
    if (isWebsiteUrl(data)) {
      return 'Website Link';
    }

    if (isGoogleMapsLink(data)) {
      return 'Google Maps Link';
    }

    if (isWifiConfig(data)) {
      return 'Wifi Data';
    }

    return '';
  }

  bool isWebsiteUrl(String? code) {
    return code != null &&
        (Uri.tryParse(code)?.scheme == 'http' ||
            Uri.tryParse(code)?.scheme == 'https');
  }

  bool isGoogleMapsLink(String? code) {
    // Add your logic to check if the code is a Google Maps link
    // For example, you can check if it contains specific keywords or patterns
    return code != null && code.contains('maps.app.goo.gl');
  }

  bool isWifiConfig(String? code) {
    var isWifi = code != null && code.startsWith('WIFI:');
    // Add your logic to check if the code is a Wi-Fi configuration
    // For example, you can check if it starts with 'WIFI:'
    // setState(() {
    //   wifiInfo = parseWifiConfig(widget.code ?? '');
    // });

    return isWifi;
  }
}

class CustomFloatingButton extends StatelessWidget {
  final Function(String) onClick;
  const CustomFloatingButton({super.key, required this.onClick});

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      splashColor: Color(0xffFFFFFF),
      onPressed: () {
        onClick('scan');
      },
      backgroundColor: Color(0xFFFDB623),
      shape: const CircleBorder(),
      child: Container(
          decoration: BoxDecoration(
              color: Color(0xFFFDB623),
              borderRadius: BorderRadius.all(
                Radius.circular(100),
              ),
              boxShadow: [
                BoxShadow(
                  color: Color(0xFFFDB623).withOpacity(0.5),
                  spreadRadius: 7,
                  blurRadius: 12,
                  // offset: Offset(0, 5),
                )
              ]),
          child: Center(
            child: Image.asset(
              'assets/images/qr_scan_float.png',
              height: 30,
            ),
          )),
    );
  }
}

// ignore: must_be_immutable
class QRMenu extends StatelessWidget {
  final Function(String) onClick;
  QRMenu({super.key, required this.onClick});

  @override
  Widget build(BuildContext context) {
    return Stack(
      clipBehavior: Clip.none,
      alignment: Alignment.center,
      children: [
        Container(
          margin: EdgeInsets.only(bottom: 50, top: 20),
          child: Center(
            child: Container(
              width: MediaQuery.of(context).size.width * 0.8,
              padding: EdgeInsets.all(10),
              decoration: BoxDecoration(
                  boxShadow: [
                    BoxShadow(
                      spreadRadius: 1,
                      blurRadius: 10,
                      offset: Offset(1, 3), // changes position of shadow
                    ),
                  ],
                  border: Border(
                      bottom: BorderSide(
                          color: Color(0xFFFDB623),
                          width: 3,
                          style: BorderStyle.solid)),
                  color: Color(0xff414140),
                  borderRadius: BorderRadius.all(Radius.circular(10))),
              child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    MenuOption(
                      onClick: onClick,
                      menuName: 'generate',
                      asset: 'assets/images/qr_menu.png',
                    ),
                    MenuOption(
                      onClick: onClick,
                      menuName: 'history',
                      asset: 'assets/images/history_menu.png',
                    )
                  ]),
            ),
          ),
        ),
        Positioned(
          top: -8,
          child: Align(
              alignment: Alignment.topCenter,
              child: Container(
                  child: CustomFloatingButton(
                onClick: onClick,
              ))),
        ),
      ],
    );
  }
}
