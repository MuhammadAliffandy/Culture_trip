import 'package:flutter/material.dart';

// ignore: must_be_immutable
class EditInput extends StatelessWidget {
  TextEditingController? myController = TextEditingController();
  String? labelAwal;
  String? labelAkhir;
  var logicValidation;

  EditInput({
    this.labelAwal,
    this.labelAkhir,
    this.myController,
    this.logicValidation,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 8, horizontal: 20),
      child: TextFormField(
        controller: myController,
        validator: logicValidation,
        style: TextStyle(color: Color.fromARGB(255, 0, 0, 0)),
        decoration: InputDecoration(
          filled: true,
          fillColor: Colors.white,
          enabledBorder: UnderlineInputBorder(
            borderSide: BorderSide(color: Colors.black),
          ),
          focusedBorder: UnderlineInputBorder(
            borderSide: BorderSide(color: Theme.of(context).primaryColor),
          ),
          labelText: labelAwal,
          labelStyle: TextStyle(color: Color.fromARGB(159, 116, 114, 114)),
          floatingLabelStyle: TextStyle(color: Theme.of(context).primaryColor),
          hintText: labelAkhir,
          hintStyle: TextStyle(color: Color.fromARGB(159, 116, 114, 114)),
        ),
      ),
    );
  }
}
