import 'package:flutter/material.dart';

// ignore: must_be_immutable
class NavAkun extends StatelessWidget {
  dynamic textContent;
  dynamic textButton;
  var functionButton;

  NavAkun({this.textButton, this.textContent, this.functionButton});

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Container(
      width: 350,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            textContent,
            style: TextStyle(fontSize: 12, color: Colors.black, fontFamily: 'Poppins'),
          ),
          TextButton(
            onPressed: functionButton,
            child: Text(
              textButton,
              style: TextStyle(fontSize: 12, color: Theme.of(context).primaryColor, fontFamily: 'Poppins'),
            ),
            style: ButtonStyle(
              minimumSize: MaterialStateProperty.all(Size(0, 0)),
            ),
          )
        ],
      ),
    );
  }
}
