import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
// import 'package:qr_barcode_scanner/main.dart';
// import 'package:qr_code_scanner/qr_code_scanner.dart';
import 'package:lottie/lottie.dart';

class QRScanView extends StatefulWidget {
  const QRScanView({super.key});

  @override
  State<QRScanView> createState() => _QRScanViewState();
}

class _QRScanViewState extends State<QRScanView> {
  // Barcode? result;
  // QRViewController? controller;
  final GlobalKey qrKey = GlobalKey(debugLabel: 'QR');

  Future<bool> onWillPopScope() async {
    Navigator.pop(context);
    return false;
  }

  // In order to get hot reload to work we need to pause the camera if the platform
  // is android, or resume the camera if the platform is iOS.
  @override
  void reassemble() {
    super.reassemble();
    // if (Platform.isAndroid) {
    //   controller!.pauseCamera();
    // }
    // controller!.resumeCamera();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        alignment: Alignment.bottomCenter,
        children: [
          // Consumer<QrScanVM>(builder: (context, provider, _) {
          //   if (!provider.showQrView) {
          //     return const SizedBox();
          //   }

          // Padding(
          //   padding: const EdgeInsets.only(top: 20),
          //   child: QRView(
          //     onPermissionSet: (ctrl, permission) async {
          //       if (kDebugMode) {
          //         print('$permission');
          //       }
          //     },
          //     key: qrKey,
          //     onQRViewCreated: (QRViewController qrController) {
          //       // context.read<QrScanVM>().scan(context, qrController);
          //     },
          //     overlay: QrScannerOverlayShape(
          //       borderColor: Colors.black.withOpacity(0.9),
          //       borderRadius: 0,
          //       borderLength: 40,
          //       overlayColor: Colors.black.withOpacity(0.9),
          //       borderWidth: 1,
          //       cutOutSize: MediaQuery.of(context).size.height * 0.76,
          //     ),
          //   ),
          // ),
          // }),
          Center(
            child: Image.asset(
              'assets/images/rectangle_scan.png',
              width: MediaQuery.of(context).size.width * 0.80,
              fit: BoxFit.fitWidth,
            ),
          ),
          Center(
            child: LottieBuilder.asset(
              "assets/anim/animation-scan.json",
              width: MediaQuery.of(context).size.width * 0.76,
              fit: BoxFit.fitWidth,
            ),
          ),
          buildFooter(),
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            child: AppBar(
              backgroundColor: Colors.transparent,
              titleSpacing: 0,
              elevation: 0,
              title: Text(
                "Scan QR",
                style: TextStyle(color: Colors.white),
              ),
              leading: Builder(builder: (context) {
                return IconButton(
                  icon: const Icon(
                    Icons.arrow_back,
                    color: Colors.white,
                  ),
                  onPressed: onWillPopScope,
                );
              }),
            ),
          ),
        ],
      ),
    );
  }

  Widget body() {
    return Container();
  }

  Widget buildFooter() {
    return Padding(
      padding: EdgeInsets.all(16),
      child: SizedBox(
        width: double.infinity,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            // GestureDetector(
            //   key: const Key('flashButton'),
            //   onTap: provider.toggleFlash,
            //   child: FutureBuilder(
            //     future: provider.qrController?.getFlashStatus(),
            //     builder: (context, snapshot) {
            //       return IImage(
            //         image: provider.flashActive ? 'assets/icons/flash_open.png' : 'assets/icons/flash_close.png',
            //         width: 45,
            //         height: 45,
            //         fit: BoxFit.contain,
            //       );
            //     },
            //   ),
            // ),
            GestureDetector(
              key: const Key('galleryButton'),
              onTap: () {},
              child: Image.asset(
                'assets/icons/pick_image.png',
                width: 45,
                height: 45,
                fit: BoxFit.contain,
              ),
            )
          ],
        ),
      ),
    );
  }
}
