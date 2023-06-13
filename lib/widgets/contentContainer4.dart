import 'package:culture_trip/models/paketWisata.dart';
import 'package:flutter/material.dart';

// ignore: must_be_immutable
class ContentContainer4 extends StatefulWidget {
  dynamic textContent;
  dynamic subTextContent;
  dynamic dateContent;
  dynamic photoContent;
  dynamic functionButton;
  dynamic tanggal;
  dynamic optionButton;

  ContentContainer4({
    this.textContent,
    this.subTextContent,
    this.photoContent,
    this.functionButton,
    this.tanggal,
    this.optionButton,
  });

  @override
  State<ContentContainer4> createState() => _ContentContainer4State();
}

class _ContentContainer4State extends State<ContentContainer4> {
  final AllPaket = new PaketWisata();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 10),
      child: Container(
        width: 365,
        height: 150,
        decoration: BoxDecoration(
          image: DecorationImage(
              fit: BoxFit.cover,
              image: NetworkImage(
                widget.photoContent,
              )),
          color: Colors.red,
          borderRadius: BorderRadius.circular(10),
          boxShadow: [
            BoxShadow(
              color: Color.fromARGB(255, 255, 141, 141),
              spreadRadius: -48,
              blurRadius: 30,
              offset: Offset(0, 35),
            )
          ],
        ),
        child: Container(
          width: 365,
          height: 150,
          child: Container(
            decoration: BoxDecoration(
              color: Color.fromARGB(144, 40, 40, 40),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Stack(children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Padding(
                      padding: const EdgeInsets.all(15),
                      child: Container(
                        width: 350,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  widget.textContent,
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontFamily: 'Poppins ',
                                    fontWeight: FontWeight.bold,
                                    fontSize: 18,
                                    shadows: [
                                      Shadow(
                                        color: Color.fromARGB(255, 89, 89, 89),
                                        blurRadius: 2,
                                        offset: Offset(0, 2),
                                      )
                                    ],
                                  ),
                                ),
                                GestureDetector(
                                  onTap: () {
                                    showDialog(
                                        context: context,
                                        builder: (context) {
                                          return AlertDialog(
                                            shape: RoundedRectangleBorder(
                                              borderRadius: BorderRadius.circular(10.0),
                                            ),
                                            actions: [
                                              Center(
                                                child: TextButton(
                                                  onPressed: widget.optionButton,
                                                  child: Text(
                                                    'batalkan',
                                                    style: TextStyle(fontSize: 17, color: Theme.of(context).primaryColor, fontWeight: FontWeight.bold),
                                                  ),
                                                ),
                                              ),
                                            ],
                                          );
                                        });
                                  },
                                  child: Column(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      Icon(
                                        Icons.more_horiz,
                                        color: Colors.white,
                                        size: 25,
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(
                              height: 2,
                            ),
                            Container(
                              width: 270,
                              height: 90,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    widget.subTextContent,
                                    maxLines: 1,
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontFamily: 'Poppins',
                                      fontWeight: FontWeight.bold,
                                      fontSize: 18,
                                      shadows: [
                                        Shadow(
                                          color: Color.fromARGB(255, 89, 89, 89),
                                          blurRadius: 2,
                                          offset: Offset(0, 2),
                                        )
                                      ],
                                    ),
                                  ),
                                  Text(
                                    widget.tanggal,
                                    maxLines: 1,
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontFamily: 'Poppins',
                                      fontSize: 12,
                                      shadows: [
                                        Shadow(
                                          color: Color.fromARGB(255, 89, 89, 89),
                                          blurRadius: 2,
                                          offset: Offset(0, 2),
                                        )
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      )),
                ],
              ),
              Positioned(
                  left: 0,
                  right: 0,
                  top: 70,
                  bottom: 0,
                  child: Padding(
                    padding: const EdgeInsets.all(13),
                    child: Container(
                      width: MediaQuery.of(context).size.width,
                      height: 60,
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
                              onPressed: widget.functionButton,
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
                  ))
            ]),
          ),
        ),
      ),
    );
  }
}
