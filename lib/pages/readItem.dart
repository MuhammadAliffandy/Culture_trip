import 'package:culture_trip/widgets/contentContainer2.dart';
import 'package:culture_trip/widgets/customNavButton.dart';
import 'package:culture_trip/widgets/customSearch.dart';
import 'package:flutter/material.dart';

class ReadItemScreen extends StatefulWidget {
  @override
  State<ReadItemScreen> createState() => _ReadItemScreenState();
}

class _ReadItemScreenState extends State<ReadItemScreen> {
  int _selectedIndex = 5;

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    //

    //
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
              Navigator.pop(context, '/readItem');
            },
            icon: Icon(
              Icons.arrow_back,
              color: Theme.of(context).primaryColor,
              size: 30,
            )),
        backgroundColor: Theme.of(context).backgroundColor,
        elevation: 0,
        title: Text(
          _title,
          style: TextStyle(
            fontSize: 22,
            color: Theme.of(context).primaryColor,
          ),
        ),
        centerTitle: true,
      ),
      backgroundColor: Colors.white,
      body: Stack(fit: StackFit.expand, children: [
        SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Column(
            children: [
              Container(
                width: MediaQuery.of(context).size.width,
                height: 330,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.only(
                      bottomRight: Radius.circular(60),
                    ),
                    image: DecorationImage(
                      fit: BoxFit.cover,
                      image: NetworkImage(_gambar),
                    )),
                child: Center(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      _judul,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Colors.white,
                        fontFamily: 'Poppins',
                        fontWeight: FontWeight.bold,
                        fontSize: 30,
                      ),
                    ),
                  ),
                ),
              ),
              Container(
                width: MediaQuery.of(context).size.width,
                child: Padding(
                  padding: const EdgeInsets.all(25),
                  child: Text(
                    _artikel,
                    overflow: TextOverflow.clip,
                    maxLines: null,
                    style: TextStyle(
                      fontSize: 15,
                      color: Colors.black,
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 120,
              ),
            ],
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
