import 'package:flutter/material.dart';

class CustomSearch extends StatelessWidget {
  final MyController;
  dynamic? functionField;

  CustomSearch({this.MyController, this.functionField});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 28),
      child: Center(
        child: Container(
          width: MediaQuery.of(context).size.width,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15),
            boxShadow: [
              BoxShadow(
                color: Color.fromARGB(255, 179, 179, 179),
                spreadRadius: -7,
                blurRadius: 7,
                offset: Offset(0, 7),
              )
            ],
          ),
          child: TextField(
            onChanged: functionField,
            controller: MyController,
            style: TextStyle(color: Color.fromARGB(255, 0, 0, 0)),
            decoration: InputDecoration(
                filled: true,
                fillColor: Colors.white,
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide.none,
                  borderRadius: BorderRadius.all(Radius.circular(15)),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Theme.of(context).primaryColor),
                  borderRadius: BorderRadius.all(Radius.circular(15)),
                ),
                labelStyle: TextStyle(color: Color.fromARGB(159, 116, 114, 114)),
                floatingLabelStyle: TextStyle(color: Theme.of(context).primaryColor),
                hintText: 'Search',
                hintStyle: TextStyle(color: Color.fromARGB(159, 116, 114, 114)),
                suffixIcon: Icon(
                  Icons.search,
                  color: Theme.of(context).primaryColor,
                )),
          ),
        ),
      ),
    );
  }
}
