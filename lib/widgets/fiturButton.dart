import 'package:flutter/material.dart';

// ignore: must_be_immutable
class FiturButton extends StatelessWidget {
  dynamic icon;
  dynamic warnaIcon;
  dynamic textFitur;
  dynamic functionButton;

  FiturButton({this.icon, this.warnaIcon, this.textFitur, this.functionButton});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 7),
      child: Container(
        width: 80,
        height: 77,
        decoration: BoxDecoration(
          color: Color.fromARGB(255, 255, 255, 255),
          borderRadius: BorderRadius.circular(10),
          boxShadow: [
            BoxShadow(
              color: Color.fromARGB(255, 66, 66, 66),
              spreadRadius: -7,
              blurRadius: 7,
              offset: Offset(0, 7),
            )
          ],
        ),
        child: Column(
          children: [
            IconButton(
              onPressed: functionButton,
              icon: Icon(
                icon,
                color: warnaIcon,
                size: 30,
              ),
            ),
            Text(
              textFitur,
              style: TextStyle(
                color: Colors.black,
                fontFamily: 'Poppins',
                fontWeight: FontWeight.w500,
                fontSize: 11,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
