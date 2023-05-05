import 'package:flutter/material.dart';

class TextWisata extends StatelessWidget {
  List<Widget> listChild = [
    Text('kosong'),
  ];

  String textContent;

  TextWisata({required this.listChild, required this.textContent});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Divider(
          height: 25,
          thickness: 2,
          color: Color.fromARGB(112, 158, 158, 158),
        ),
        Text(
          textContent,
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 14,
          ),
        ),
        Container(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(children: listChild),
          ),
        )
      ],
    );
  }
}
