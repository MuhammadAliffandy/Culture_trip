import 'package:flutter/material.dart';

class FormInput extends StatelessWidget {
  TextEditingController? myController = TextEditingController();
  String? labelAwal;
  String? labelAkhir;
  bool? typeInput;
  var logicValidation;

  FormInput({this.labelAwal, this.labelAkhir, this.myController, this.logicValidation, this.typeInput});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: Container(
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
        width: 297,
        child: TextFormField(
          controller: myController,
          validator: logicValidation,
          obscureText: typeInput!,
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
            labelText: labelAwal,
            labelStyle: TextStyle(color: Color.fromARGB(159, 116, 114, 114)),
            floatingLabelStyle: TextStyle(color: Theme.of(context).primaryColor),
            hintText: labelAkhir,
            hintStyle: TextStyle(color: Color.fromARGB(159, 116, 114, 114)),
          ),
        ),
      ),
    );
  }
}
