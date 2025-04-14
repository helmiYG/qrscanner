import 'dart:developer';
import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:qr_barcode_scanner/page/result_view.dart';
import 'package:qr_barcode_scanner/page/scan_view.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';
import 'package:lottie/lottie.dart';
import 'package:qr_barcode_scanner/page/onboard_view.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(428, 926),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (context, child) {
        return MaterialApp(
          title: 'Flutter Demo',
          theme: ThemeData(
            colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
            useMaterial3: true,
          ),
          home: OnBoarding(),
        );
      },
    );
  }
}

class MyHome extends StatelessWidget {
  const MyHome({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Center(child: const Text('QR Scanner'))),
      body: Center(
        child: ElevatedButton(
          onPressed: () async {
            // https://maps.app.goo.gl/QNvXuWeSbjmdc9Kx8
            Navigator.of(context).push(MaterialPageRoute(
              builder: (context) => const QRViewExample(),
            ));
          },
          style: ElevatedButton.styleFrom(
            backgroundColor: Color.fromARGB(255, 68, 224, 255),
            padding: EdgeInsets.symmetric(horizontal: 24, vertical: 12),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
            ),
          ),
          child: Text(
            'Start Scanning',
            style: TextStyle(fontSize: 18, color: Colors.white),
          ),
        ),
      ),
    );
  }
}

class QRViewExample extends StatefulWidget {
  const QRViewExample({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _QRViewExampleState();
}

class _QRViewExampleState extends State<QRViewExample> {
  Barcode? result;
  QRViewController? controller;
  final GlobalKey qrKey = GlobalKey(debugLabel: 'QR');

  Future<bool> onWillPopScope() async {
    return false;
  }

  @override
  void initState() {
    super.initState();
  }

  // In order to get hot reload to work we need to pause the camera if the platform
  // is android, or resume the camera if the platform is iOS.
  @override
  void reassemble() {
    super.reassemble();
    if (Platform.isAndroid) {
      controller!.pauseCamera();
    }
    controller!.resumeCamera();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        alignment: Alignment.bottomCenter,
        children: <Widget>[
          _buildQrView(context),
          Center(
            child: LottieBuilder.asset(
              "assets/anim/animation-scan.json",
              width: MediaQuery.of(context).size.width * 0.76,
              fit: BoxFit.fitWidth,
            ),
          ),
          buildFooter()
        ],
      ),
    );
  }

  Widget buildFooter() {
    return Padding(
      padding: EdgeInsets.all(16),
      child: SizedBox(
        width: double.infinity,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            GestureDetector(
              key: const Key('flashButton'),
              onTap: () {},
              child: FutureBuilder(
                future: controller?.getFlashStatus(),
                builder: (context, snapshot) {
                  return Icon(
                    Icons.flash_off,
                    color: Colors.white,
                  );
                },
              ),
            ),
            GestureDetector(
                key: const Key('galleryButton'),
                onTap: () async {
                  await controller?.flipCamera();
                  setState(() {});
                },
                child: FutureBuilder(
                  future: controller?.getCameraInfo(),
                  builder: (context, snapshot) {
                    if (snapshot.data != null) {
                      return Icon(
                        describeEnum(snapshot.data!) == 'front'
                            ? Icons.flip_camera_android
                            : Icons.flip_camera_android_outlined,
                        color: Colors.white,
                      );
                      // Text(
                      //     'Camera facing ${describeEnum(snapshot.data!)}');
                    } else {
                      return const Text('loading');
                    }
                  },
                )),
          ],
        ),
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
          borderColor: const Color.fromARGB(255, 68, 224, 255),
          borderRadius: 10,
          borderLength: 30,
          borderWidth: 10,
          cutOutSize: scanArea),
      onPermissionSet: (ctrl, p) => _onPermissionSet(context, ctrl, p),
    );
  }

  void _onQRViewCreated(QRViewController controller) {
    var lastQrCodeReadDate = DateTime.now();
    setState(() {
      this.controller = controller;
    });
    controller.scannedDataStream.listen((scanData) async {
      final dateNow = DateTime.now();
      if (dateNow.difference(lastQrCodeReadDate).inSeconds < 3) return;
      await controller.pauseCamera();
      if (scanData.code != null) {
        Navigator.of(context).push(MaterialPageRoute(
          builder: (context) => ResultView(
            code: scanData.code,
            format: describeEnum(scanData.format),
          ),
        ));
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

  @override
  void dispose() {
    controller?.dispose();
    super.dispose();
  }
}
