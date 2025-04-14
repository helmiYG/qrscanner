import 'package:flutter/material.dart';
import 'package:qr_barcode_scanner/page/home_page/home_qris_view.dart';

class OnBoarding extends StatelessWidget {
  OnBoarding({super.key});

  @override
  Widget build(BuildContext context) {
    var heightBtshet = MediaQuery.of(context).size.height * (339 / 926);
    return Scaffold(
      backgroundColor: Color(0xFFFDB623),
      body: Container(
        child: Stack(
          children: [
            Align(
              alignment: Alignment.topCenter,
              child: Container(
                margin: EdgeInsets.only(
                    top: MediaQuery.of(context).size.width * 0.4),
                child: Image.asset(
                  'assets/images/qr_icon.png',
                  width: MediaQuery.of(context).size.width * 0.3,
                ),
              ),
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: Container(
                width: MediaQuery.of(context).size.width,
                // height: 339.h,
                height: heightBtshet,
                decoration: BoxDecoration(
                    boxShadow: [
                      BoxShadow(
                        spreadRadius: 2,
                        blurRadius: 6,
                        offset: Offset(0, 3), // changes position of shadow
                      ),
                    ],
                    color: Color(0xFF333333),
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(61),
                        topRight: Radius.circular(61))),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      margin: EdgeInsets.only(top: 20),
                      width: MediaQuery.of(context).size.width * 0.3,
                      height: 5,
                      decoration: BoxDecoration(
                          color: Color(0xFFFDB623),
                          borderRadius: BorderRadius.all(Radius.circular(50))),
                    ),
                    Container(
                        // margin: EdgeInsets.only(top: 10, left: 20, right: 20),
                        child: Column(
                      children: [
                        Text(
                          'Get Started',
                          style: TextStyle(
                              fontSize: 42,
                              color: Colors.white,
                              fontStyle: FontStyle.normal,
                              fontWeight: FontWeight.w700,
                              fontFamily: 'Itim'),
                        ),
                        Center(
                          child: Text(
                            'Go and enjoy our features for free and make your life easy with us.',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 14,
                                fontStyle: FontStyle.normal,
                                fontWeight: FontWeight.w700,
                                fontFamily: 'Itim'),
                          ),
                        ),
                      ],
                    )),
                    Container(
                      width: 200,
                      margin: EdgeInsets.only(bottom: 10),
                      child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Color(0xFFFDB623),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                            elevation: 0,
                          ),
                          onPressed: () {
                            Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) => const HomeQRIS(),
                            ));
                          },
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Container(),
                              Text(
                                'Lets Go',
                                style: TextStyle(
                                    fontSize: 16,
                                    color: Color(0xFF333333),
                                    fontStyle: FontStyle.normal,
                                    fontWeight: FontWeight.w700,
                                    fontFamily: 'Itim'),
                              ),
                              Icon(
                                Icons.arrow_forward,
                                color: Color(0xFF333333),
                              )
                            ],
                          )),
                    )
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}

class CustomBottomNavBar extends StatelessWidget {
  const CustomBottomNavBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.fromLTRB(10, 0, 10, 20),
      decoration: BoxDecoration(boxShadow: [
        BoxShadow(
          color: Colors.amber,
          blurRadius: 7,
          offset: Offset(2, 7),
          spreadRadius: 7,
        )
      ]),
      child: BottomAppBar(
        shadowColor: Color(0xff414140).withOpacity(0.2),
        color: Color(0xff414140),
        // shape: const CircularNotchedRectangle(),
        // notchMargin: 10,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            _buildNavItem(Icons.qr_code, "Generate"),
            const SizedBox(width: 50), // Spacer untuk FAB
            _buildNavItem(Icons.history, "History"),
          ],
        ),
      ),
    );
  }

  Widget _buildNavItem(IconData icon, String label) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(icon, color: Colors.white),
        const SizedBox(height: 4),
        Text(label, style: const TextStyle(color: Colors.white, fontSize: 12)),
      ],
    );
  }
}
