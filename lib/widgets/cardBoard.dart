import 'package:flutter/material.dart';

// ignore: must_be_immutable
class CardBoard extends StatelessWidget {
  dynamic textContent;
  dynamic textTier;
  dynamic numberTrip;

  CardBoard({this.numberTrip, this.textContent, this.textTier});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
        child: Center(
          child: Container(
              height: 140,
              decoration: BoxDecoration(
                color: Colors.white,
                border: Border.all(
                  color: Theme.of(context).primaryColor,
                  width: 2,
                ),
                borderRadius: BorderRadius.circular(10),
                boxShadow: [
                  BoxShadow(
                    color: Color.fromARGB(255, 255, 141, 141),
                    spreadRadius: -48,
                    blurRadius: 30,
                    offset: Offset(0, 42),
                  )
                ],
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(
                      vertical: 18,
                    ),
                    child: Container(
                      width: 200,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Text(
                                textContent,
                                style: TextStyle(
                                  fontFamily: 'Poppins',
                                  fontWeight: FontWeight.bold,
                                  fontSize: 24,
                                ),
                              ),
                              SizedBox(
                                width: 10,
                              ),
                              Container(
                                decoration: BoxDecoration(
                                  color: Theme.of(context).primaryColor,
                                  borderRadius: BorderRadius.circular(5),
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 3),
                                  child: Row(
                                    children: [
                                      Text(
                                        textTier,
                                        style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 10, fontFamily: 'Poppins'),
                                      ),
                                      SizedBox(
                                        width: 5,
                                      ),
                                      Image(
                                        image: AssetImage('lib/assets/images/Bronze.png'),
                                        width: 20,
                                        height: 20,
                                      )
                                    ],
                                  ),
                                ),
                              )
                            ],
                          ),
                          SizedBox(
                            height: 8,
                          ),
                          Text(
                            'Yuk Bewisata lebih banyak untuk menaikkan peringkat anda dan dapatkan bonus terbaiknya. ',
                            maxLines: 3,
                            style: TextStyle(
                              fontFamily: 'Poppins',
                              fontSize: 12,
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                  Container(
                    width: 110,
                    height: 110,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      shape: BoxShape.circle,
                      border: Border.all(
                        color: Theme.of(context).primaryColor,
                        width: 2.0,
                      ),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          numberTrip,
                          style: TextStyle(color: Theme.of(context).primaryColor, fontSize: 28, fontFamily: 'Poppins'),
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        Text(
                          'Perjalanan',
                          style: TextStyle(color: Theme.of(context).primaryColor, fontFamily: 'Poppins', fontSize: 12),
                        ),
                      ],
                    ),
                  ),
                ],
              )),
        ),
      ),
    );
  }
}
