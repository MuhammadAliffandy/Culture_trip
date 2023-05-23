import 'package:culture_trip/widgets/contentContainer3.dart';
import 'package:culture_trip/widgets/customNavButton.dart';
import 'package:culture_trip/widgets/customSearch.dart';
import 'package:flutter/material.dart';

class ReadInformasiScreen extends StatefulWidget {
  @override
  State<ReadInformasiScreen> createState() => _ReadInformasiScreenState();
}

class _ReadInformasiScreenState extends State<ReadInformasiScreen> {
  int _selectedIndex = 5;

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    final Map<String, dynamic>? arguments = ModalRoute.of(context)?.settings.arguments as Map<String, dynamic>?;
    var _toRoute = arguments?['toRoute'];
    var _title = arguments?['title'];
    var _judul = arguments?['judul'];
    var _artikel = arguments?['artikel'];
    var _gambar = arguments?['gambar'];

    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
            onPressed: () {
              Navigator.pop(context, '/readInfo');
            },
            icon: Icon(
              Icons.arrow_back,
              color: Theme.of(context).primaryColor,
              size: 30,
            )),
        backgroundColor: Theme.of(context).backgroundColor,
        elevation: 0,
        title: Text(
          'Informasi',
          style: TextStyle(
            fontSize: 22,
            color: Theme.of(context).primaryColor,
          ),
        ),
        centerTitle: true,
      ),
      backgroundColor: Theme.of(context).backgroundColor,
      body: Stack(fit: StackFit.expand, children: [
        Padding(
          padding: const EdgeInsets.only(top: 40),
          child: Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(50),
                  topRight: Radius.circular(50),
                ),
                boxShadow: [
                  BoxShadow(
                    color: Color.fromARGB(78, 138, 138, 138),
                    blurRadius: 10,
                    offset: Offset(0, -10),
                  )
                ]),
            child: SingleChildScrollView(
                scrollDirection: Axis.vertical,
                child: Padding(
                  padding: const EdgeInsets.all(30),
                  child: Container(
                    width: MediaQuery.of(context).size.width,
                    child: Container(
                      width: MediaQuery.of(context).size.width,
                      child: Column(
                        children: [
                          Text(
                            _judul,
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: 22,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          SizedBox(
                            height: 30,
                          ),
                          Text(
                            _artikel,
                            style: TextStyle(
                              fontSize: 15,
                              fontFamily: 'Poppins',
                            ),
                          ),
                          SizedBox(
                            height: 120,
                          ),
                        ],
                      ),
                    ),
                  ),
                )),
          ),
        ),
        Positioned(
          top: 0,
          left: 0,
          bottom: 10,
          right: 0,
          child: CustomNavButton(
            selectedIndex: _selectedIndex,
            onItemTapped: _onItemTapped,
          ),
        ),
      ]),
    );
  }
}
