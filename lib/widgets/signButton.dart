// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';

// ignore: camel_case_types
class signButton extends StatelessWidget {
  dynamic functionButton;
  dynamic textButton;
  signButton({this.functionButton, this.textButton});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: functionButton,
      style: ButtonStyle(
        backgroundColor: MaterialStatePropertyAll(Theme.of(context).primaryColor),
        minimumSize: MaterialStateProperty.all(Size(297, 58)),
        shape: MaterialStateProperty.all<RoundedRectangleBorder>(
          RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(28),
          ),
        ),
      ),
      child: Text(
        textButton,
        style: TextStyle(fontSize: 20, fontFamily: 'Poppins', color: Colors.white),
      ),
    );
  }
}

class signupButton extends StatelessWidget {
  dynamic functionButton;

  signupButton({this.functionButton});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: functionButton,
      style: ButtonStyle(
        backgroundColor: MaterialStatePropertyAll(Colors.white),
        minimumSize: MaterialStateProperty.all(Size(297, 58)),
        shape: MaterialStateProperty.all<RoundedRectangleBorder>(
          RoundedRectangleBorder(borderRadius: BorderRadius.circular(28), side: BorderSide(color: Theme.of(context).primaryColor)),
        ),
      ),
      child: Text(
        'Sign Up',
        style: TextStyle(fontSize: 20, fontFamily: 'Poppins', color: Theme.of(context).primaryColor),
      ),
    );
  }
}
