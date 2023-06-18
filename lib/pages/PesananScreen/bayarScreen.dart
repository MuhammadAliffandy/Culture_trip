import 'package:flutter/material.dart';

class BayarScreen extends StatefulWidget {
  @override
  State<BayarScreen> createState() => _BayarScreenState();
}

class _BayarScreenState extends State<BayarScreen> {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
        appBar: AppBar(
          leading: IconButton(
              onPressed: () {
                Navigator.pop(context);
              },
              icon: Icon(
                Icons.arrow_back,
                color: Colors.white,
                size: 30,
              )),
          backgroundColor: Theme.of(context).primaryColor,
          elevation: 0,
          title: Text(
            'Pesanan',
            style: TextStyle(
              fontSize: 22,
              color: Colors.white,
            ),
          ),
          centerTitle: true,
        ),
        backgroundColor: Theme.of(context).primaryColor,
        body: Container(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          color: Theme.of(context).primaryColor,
          child: Center(
            child: Container(
              height: 500,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(20),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Culture Trip',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  Text('ID : 129029381323210'),
                  Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: Container(
                      decoration: BoxDecoration(
                        color: Color.fromARGB(123, 158, 158, 158),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Image(
                        width: 330,
                        height: 330,
                        image: AssetImage('lib/assets/images/qr.png'),
                      ),
                    ),
                  ),
                  Container(
                    width: 280,
                    child: Text(
                      'Silahkan Scan untuk melakukan pembayaran dan pastikan sesuai dengan harga yang ditetapkan',
                      textAlign: TextAlign.center,
                    ),
                  )
                ],
              ),
            ),
          ),
        ));
  }
}
