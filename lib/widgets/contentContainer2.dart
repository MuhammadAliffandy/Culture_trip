import 'package:flutter/material.dart';

class ContentContainer2 extends StatelessWidget {
  dynamic? textContent;
  dynamic? photoContent;
  dynamic? functionButton;

  ContentContainer2({this.textContent, this.photoContent, this.functionButton});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10),
      child: Container(
        width: 365,
        height: 150,
        decoration: BoxDecoration(
          image: DecorationImage(
              fit: BoxFit.cover,
              image: AssetImage(
                photoContent,
              )),
          color: Colors.red,
          borderRadius: BorderRadius.circular(10),
          boxShadow: [
            BoxShadow(
              color: Color.fromARGB(255, 255, 141, 141),
              spreadRadius: -48,
              blurRadius: 30,
              offset: Offset(0, 38),
            )
          ],
        ),
        child: Container(
          width: 365,
          height: 150,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Padding(
                padding: const EdgeInsets.all(10),
                child: Text(
                  textContent,
                  style: TextStyle(
                    color: Colors.white,
                    fontFamily: 'Poppins',
                    fontSize: 16,
                    shadows: [
                      Shadow(
                        color: Color.fromARGB(255, 89, 89, 89),
                        blurRadius: 2,
                        offset: Offset(0, 2),
                      )
                    ],
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(13),
                child: Container(
                  width: MediaQuery.of(context).size.width,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Container(
                        width: 45,
                        height: 45,
                        decoration: BoxDecoration(
                          color: Color.fromARGB(82, 232, 232, 232),
                          shape: BoxShape.circle,
                        ),
                        child: IconButton(
                          onPressed: functionButton,
                          icon: Icon(
                            Icons.keyboard_double_arrow_right,
                            size: 25,
                            color: Color.fromARGB(255, 236, 233, 233),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
