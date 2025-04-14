import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:qr_barcode_scanner/page/module/header_container.dart';

class ScanOptions extends StatelessWidget {
  const ScanOptions({super.key});

  @override
  Widget build(BuildContext context) {
    return HeaderContainer(children: [
      InkWell(
          onTap: () {},
          child: Image.asset(
            'assets/images/image-gallery.png',
          )),
      InkWell(
          onTap: () {},
          child: Image.asset(
            'assets/images/flash.png',
          )),
      InkWell(
          onTap: () {},
          child: Image.asset(
            'assets/images/flip-camera.png',
          )),
    ]);
  }
}
