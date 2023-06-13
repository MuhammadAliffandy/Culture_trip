import 'package:flutter/material.dart';

// ignore: must_be_immutable
class TextProfile extends StatelessWidget {
  dynamic textContent;
  dynamic subTextContent;

  TextProfile({this.textContent, this.subTextContent});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Divider(
            thickness: 1,
            height: 5,
            color: Theme.of(context).primaryColor,
          ),
          SizedBox(
            height: 15,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  textContent,
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    fontFamily: 'Poppins',
                  ),
                ),
                SizedBox(
                  height: 6,
                ),
                Text(
                  subTextContent,
                  maxLines: 2,
                  style: TextStyle(fontSize: 12, fontFamily: 'Poppins'),
                ),
              ],
            ),
          ),
          SizedBox(
            height: 10,
          ),
        ],
      ),
    );
  }
}
