import 'package:culture_trip/widgets/berandaContainer.dart';
import 'package:culture_trip/widgets/contentContainer.dart';
import 'package:culture_trip/widgets/customNavButton.dart';
import 'package:culture_trip/widgets/customSearch.dart';
import 'package:culture_trip/widgets/listTab.dart';
import 'package:culture_trip/widgets/textWisata.dart';
import 'package:flutter/material.dart';

class ReadPaketScreen extends StatefulWidget {
  @override
  State<ReadPaketScreen> createState() => _ReadPaketScreenState();
}

class _ReadPaketScreenState extends State<ReadPaketScreen> {
  int _selectedIndex = 5;

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    final List<Widget> MyTab = [
      Tab(
        text: 'Paket 1',
      ),
      Tab(
        text: 'Paket 2',
      ),
      Tab(
        text: 'Paket 3',
      ),
    ];

    // TODO: implement build
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          leading: IconButton(
              onPressed: () {
                Navigator.pop(context, '/wisata');
              },
              icon: Icon(
                Icons.arrow_back,
                color: Colors.white,
                size: 30,
              )),
          backgroundColor: Theme.of(context).primaryColor,
          elevation: 0,
          title: Text(
            'Paket',
            style: TextStyle(
              fontSize: 22,
              color: Colors.white,
            ),
          ),
          centerTitle: true,
          bottom: TabBar(
            tabs: MyTab,
          ),
        ),
        backgroundColor: Theme.of(context).backgroundColor,
        bottomNavigationBar: Container(
          color: Colors.white,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  '12 November 2009',
                  style: TextStyle(color: Colors.grey, fontSize: 12),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: ElevatedButton(
                  onPressed: () {},
                  child: Text(
                    'Pesan',
                    style: TextStyle(fontSize: 16),
                  ),
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all(Theme.of(context).primaryColor),
                    minimumSize: MaterialStateProperty.all(
                      Size(112, 46),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
        body: TabBarView(children: [
          ListTab(
            listDestinasi: [
              Text('kosong'),
            ],
            listBajuAdat: [
              Text('kosong'),
            ],
            listPenginapan: [
              Text('kosong'),
              Text('kosong'),
              Text('kosong'),
            ],
          ),
          ListTab(
            listDestinasi: [
              Text('kosong'),
            ],
            listBajuAdat: [
              Text('kosong'),
            ],
            listPenginapan: [
              Text('kosong'),
              Text('kosong'),
              Text('kosong'),
            ],
          ),
          ListTab(
            listDestinasi: [
              Text('kosong'),
            ],
            listBajuAdat: [
              Text('kosong'),
            ],
            listPenginapan: [
              Text('kosong'),
              Text('kosong'),
              Text('kosong'),
            ],
          ),
        ]),
      ),
    );
  }
}
