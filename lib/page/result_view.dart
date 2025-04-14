import 'package:flutter/material.dart';
// import 'package:url_launcher/url_launcher.dart';

class ResultView extends StatefulWidget {
  final String? code;
  final String? format;

  const ResultView({Key? key, this.code, this.format}) : super(key: key);

  @override
  State<ResultView> createState() => _ResultViewState();
}

class _ResultViewState extends State<ResultView> {
  late Map<String, dynamic> wifiInfo;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(child: Text('QR Code Result')),
        automaticallyImplyLeading: false, // Remove back icon
        backgroundColor: const Color.fromARGB(255, 68, 224, 255),
      ),
      body: Stack(
        children: [
          // Main content
          Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  Color.fromARGB(255, 68, 224, 255).withOpacity(0.7),
                  Color.fromARGB(255, 68, 224, 255).withOpacity(0.1)
                ],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
              ),
            ),
            padding: EdgeInsets.all(24),
            child: Center(
              child: CircularProgressIndicator(),
            ),
          ),
          // BottomSheet
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: Container(
              height: MediaQuery.of(context).size.height -
                  (MediaQuery.of(context).size.height * 0.2), // Set max height
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(50),
                  topRight: Radius.circular(50),
                ),
              ),
              padding: EdgeInsets.all(24),
              child: SingleChildScrollView(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(
                      Icons.check_circle,
                      color: Colors.green,
                      size: 80,
                    ),
                    SizedBox(height: 16),
                    Text(
                      'Code Scanned:',
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                    SizedBox(height: 8),
                    if (isGoogleMapsLink(widget.code)) ...[
                      _buildGoogleMapsLink(widget.code!)
                    ] else if (isWebsiteUrl(widget.code)) ...[
                      buildClickableLink(widget.code!)
                    ] else if (isWifiConfig(widget.code)) ...[
                      buildWifiInfoItem(
                          'SSID', wifiInfo['S'] ?? 'Not available'),
                      buildWifiInfoItem(
                          'Security Type', wifiInfo['T'] ?? 'Not available'),
                      buildWifiInfoItem(
                          'Password', wifiInfo['P'] ?? 'Not available'),
                      buildWifiInfoItem(
                          'Hidden', wifiInfo['H'] == 'true' ? 'Yes' : 'No'),
                    ] else ...[
                      Text(
                        'The scanned QR code type is not supported by this app.',
                        style: TextStyle(
                            fontSize: 18,
                            color: Color.fromARGB(255, 68, 224, 255)),
                        textAlign: TextAlign.center,
                      ),
                    ],
                    SizedBox(height: 16),
                    Text(
                      'Format:',
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                    SizedBox(height: 8),
                    Text(
                      widget.format?.toUpperCase() ?? 'Invalid QR code data',
                      style: TextStyle(
                          fontSize: 28,
                          color: Color.fromARGB(255, 68, 224, 255)),
                    ),
                    SizedBox(height: 32),
                    ElevatedButton(
                      onPressed: () {
                        // Navigator.pop(context);
                        Navigator.popUntil(context, (route) => route.isFirst);
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Color.fromARGB(255, 68, 224, 255),
                        padding:
                            EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                      child: Text(
                        'Close',
                        style: TextStyle(fontSize: 18, color: Colors.white),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget buildWifiInfoItem(String label, String value) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: TextStyle(fontSize: 18),
          ),
          Text(
            value,
            style: TextStyle(
                fontSize: 18, color: Color.fromARGB(255, 68, 224, 255)),
          ),
        ],
      ),
    );
  }

  Map<String, dynamic> parseWifiConfig(String wifiConfig) {
    Map<String, dynamic> wifiInfo = {};

    List<String> configParts = wifiConfig.split(';');

    for (String part in configParts) {
      List<String> keyValue = part.split(':');
      if (keyValue.length == 2) {
        wifiInfo[keyValue[0]] = keyValue[1];
      }
    }

    return wifiInfo;
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
    setState(() {
      wifiInfo = parseWifiConfig(widget.code ?? '');
    });

    return isWifi;
  }

  Widget _buildGoogleMapsLink(String mapLink) {
    return GestureDetector(
      onTap: () => launchUrl(mapLink),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text('GOOGLE MAP'),
          Text(
            mapLink,
            style: TextStyle(
              fontSize: 28,
              color: Colors.blue,
              decoration: TextDecoration.underline,
            ),
          ),
        ],
      ),
    );
  }

  Widget buildClickableLink(String url) {
    return GestureDetector(
      onTap: () => launchUrl(url),
      child: Text(
        url,
        style: TextStyle(
          fontSize: 28,
          color: Colors.blue,
          decoration: TextDecoration.underline,
        ),
      ),
    );
  }

  void launchUrl(String url) async {
    // if (await canLaunch(url)) {
    //   await launch(url);
    // } else {
    //   throw 'Could not launch $url';
    // }
  }
}
