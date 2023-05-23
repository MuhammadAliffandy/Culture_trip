import 'package:culture_trip/models/paketWisata.dart';
import 'package:flutter/material.dart';

class ContentContainer extends StatefulWidget {
  dynamic? textContent;
  dynamic? subTextContent;
  dynamic? photoContent;
  dynamic? functionButton;
  bool? isFavorited;
  dynamic? idPaket;
  ContentContainer({
    this.textContent,
    this.subTextContent,
    this.photoContent,
    this.functionButton,
    this.idPaket,
    this.isFavorited,
  });

  @override
  State<ContentContainer> createState() => _ContentContainerState();
}

class _ContentContainerState extends State<ContentContainer> {
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
                                    setState(() {
                                      widget.isFavorited == false ? widget.isFavorited = true : widget.isFavorited = false;
                                      AllPaket.upFavorite(widget.idPaket, widget.isFavorited);
                                    });
                                  },
                                  child: Column(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      Icon(
                                        widget.isFavorited == false ? Icons.favorite_border_outlined : Icons.favorite,
                                        color: Colors.white,
                                        size: 25,
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(
                              height: 5,
                            ),
                            Container(
                              width: 270,
                              child: Text(
                                widget.subTextContent,
                                maxLines: 3,
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
