import 'package:flutter/material.dart';
import 'package:qr_barcode_scanner/page/history_result/history_result.dart';
import 'package:qr_barcode_scanner/page/home_page/widgets/button.dart';
import 'package:qr_barcode_scanner/page/home_page/widgets/text.dart';

class HistoryDataModel {
  String title;
  String date;
  double id;
  String data;

  HistoryDataModel(
      {required this.title,
      required this.data,
      required this.date,
      required this.id});
}

class HistoryQr extends StatefulWidget {
  const HistoryQr({super.key});

  @override
  State<HistoryQr> createState() => _HistoryQrState();
}

class _HistoryQrState extends State<HistoryQr> {
  String category = '1';
  List<HistoryDataModel> historyScanItems = [
    HistoryDataModel(
        title: 'https://cobacoba.com',
        data: 'contoh data',
        date: '16 Dec 2022, 9:30 pm',
        id: 1),
    HistoryDataModel(
        title: 'https://cobacoba.com',
        data: 'contoh data',
        date: '16 Dec 2022, 9:30 pm',
        id: 2),
    HistoryDataModel(
        title: 'https://cobacoba.com',
        data: 'contoh data',
        date: '16 Dec 2022, 9:30 pm',
        id: 3),
    HistoryDataModel(
        title: 'https://cobacoba.com',
        data: 'contoh data',
        date: '16 Dec 2022, 9:30 pm',
        id: 4),
    HistoryDataModel(
        title: 'https://cobacoba.com',
        data: 'contoh data',
        date: '16 Dec 2022, 9:30 pm',
        id: 5),
  ];

  List<HistoryDataModel> historyCreateItem = [
    HistoryDataModel(
        title: 'https://createdscan.com',
        data: 'contoh data',
        date: '16 Dec 2022, 9:30 pm',
        id: 1),
    HistoryDataModel(
        title: 'https://createdscan.com',
        data: 'contoh data',
        date: '16 Dec 2022, 9:30 pm',
        id: 2),
    HistoryDataModel(
        title: 'https://createdscan.com',
        data: 'contoh data',
        date: '16 Dec 2022, 9:30 pm',
        id: 3),
    HistoryDataModel(
        title: 'https://createdscan.com',
        data: 'contoh data',
        date: '16 Dec 2022, 9:30 pm',
        id: 4),
    HistoryDataModel(
        title: 'https://createdscan.com',
        data: 'contoh data',
        date: '16 Dec 2022, 9:30 pm',
        id: 5),
  ];

  void changeCategory(String name) {
    setState(() {
      category = name;
    });
  }

  void showDialogPopup(double id) => showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            backgroundColor: Colors.black,
            title: TextCustom(
              fontSize: 20,
              title: 'Perhatian!',
              color: Colors.white,
            ),
            titleTextStyle: TextStyle(color: Colors.white),
            content: TextCustom(
              title: 'apakah anda yakin hapus data $id ?',
              color: Colors.white,
            ),
            actions: [
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Button(
                    onClick: () {
                      Navigator.of(context).pop();
                    },
                    selected: true,
                    title: 'iya',
                    color: Colors.white,
                    width: 80,
                  ),
                  SizedBox(
                    width: 20,
                  ),
                  Button(
                    onClick: () {
                      Navigator.of(context).pop();
                    },
                    selected: false,
                    title: 'batal',
                    color: Colors.white,
                    width: 80,
                  ),
                ],
              )
            ],
          );
        },
      );

  @override
  Widget build(BuildContext context) {
    List<HistoryDataModel> listSelected =
        category == '1' ? historyScanItems : historyCreateItem;
    return Column(
      children: [
        Container(
          margin: EdgeInsets.only(top: 40, bottom: 20),
          width: MediaQuery.of(context).size.width * 0.8,
          padding: EdgeInsets.all(5),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(5),
            color: Color(0xFF333333),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Button(
                onClick: () {
                  changeCategory('1');
                },
                selected: category == '1',
                title: 'scan',
                color: Colors.white,
              ),
              Button(
                onClick: () {
                  changeCategory('2');
                },
                selected: category == '2',
                title: 'create',
                color: Colors.white,
              )
            ],
          ),
        ),
        Expanded(
            child: ListView.builder(
          shrinkWrap: true,
          itemCount: listSelected.length,
          itemBuilder: (BuildContext context, int index) {
            return ListItem(context, listSelected[index]);
          },
        )),
      ],
    );
  }

  Widget ListItem(BuildContext context, HistoryDataModel item) {
    return GestureDetector(
      onTap: () => {
        Navigator.of(context).push(MaterialPageRoute(
            builder: (category) => HistoryResult(
                  data: item,
                )))
      },
      child: UnconstrainedBox(
        child: Container(
          width: MediaQuery.of(context).size.width * 0.8,
          margin: EdgeInsets.only(bottom: 10),
          padding: EdgeInsets.all(10),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(5),
            color: Color(0xFF333333),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  TextCustom(
                    title: item.title,
                    color: Colors.white,
                  ),
                  TextCustom(
                    fontSize: 11,
                    title: item.data,
                    color: Color(0xffA4A4A4),
                  )
                ],
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  GestureDetector(
                    onTap: () {
                      showDialogPopup(item.id);
                    },
                    child: Container(
                      // width: 30,
                      child: Icon(
                        Icons.delete_forever,
                        color: Color(0xFFFDB623),
                      ),
                    ),
                  ),
                  TextCustom(
                    fontSize: 11,
                    title: item.date,
                    color: Color(0xffA4A4A4),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
