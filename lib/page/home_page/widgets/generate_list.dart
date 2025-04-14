import 'package:flutter/material.dart';
import 'package:qr_barcode_scanner/page/generate_qr/generate_qr.dart';

class GenerateMenu extends StatelessWidget {
  final List<Map<String, dynamic>> menuItems = [
    {'label': 'Text', 'icon': Icons.text_fields},
    {'label': 'Website', 'icon': Icons.public},
    {'label': 'Wi-Fi', 'icon': Icons.wifi},
    {'label': 'Event', 'icon': Icons.event},
    {'label': 'Contact', 'icon': Icons.contact_page},
    {'label': 'Business', 'icon': Icons.business},
    {'label': 'Location', 'icon': Icons.location_on},
    {'label': 'Email', 'icon': Icons.email},
    {'label': 'Telephone', 'icon': Icons.phone},
  ];

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        child: GridView.builder(
          padding: EdgeInsets.fromLTRB(50, 60, 50, 60),
          itemCount: menuItems.length,
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 3,
              crossAxisSpacing: 30,
              mainAxisSpacing: 30,
              childAspectRatio: 1.1),
          itemBuilder: (context, index) {
            return MenuItemCard(
              icon: menuItems[index]['icon'],
              label: menuItems[index]['label'],
            );
          },
        ),
      ),
    );
  }
}

class MenuItemCard extends StatelessWidget {
  final IconData icon;
  final String label;

  const MenuItemCard({required this.icon, required this.label});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.of(context).push(MaterialPageRoute(
            builder: (cotext) => GenerateQR(
                  data: GenerateModel(label: label, icon: icon),
                )));
      },
      child: Container(
        decoration: BoxDecoration(
          color: Color(0Xff333333),
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: Color(0xFFFDB623), width: 2),
        ),
        child: Stack(
          clipBehavior: Clip.none,
          alignment: Alignment.center,
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(icon, color: Color(0xFFFDB623), size: 33),
              ],
            ),
            Positioned(
              top: -15,
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                decoration: BoxDecoration(
                  color: Color(0xFFFDB623),
                  borderRadius: BorderRadius.circular(6),
                ),
                child: Text(
                  label,
                  style: TextStyle(
                      fontSize: 12,
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                      fontFamily: 'Itim'),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
