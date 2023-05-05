import 'package:culture_trip/widgets/textWisata.dart';
import 'package:flutter/material.dart';

class ListTab extends StatelessWidget {
  List<Widget> listDestinasi;
  List<Widget> listBajuAdat;
  List<Widget> listPenginapan;
  ListTab({
    required this.listDestinasi,
    required this.listBajuAdat,
    required this.listPenginapan,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height,
      width: MediaQuery.of(context).size.width,
      child: SingleChildScrollView(
        child: Container(
          child: Padding(
            padding: const EdgeInsets.all(15),
            child: Center(
              child: Container(
                height: MediaQuery.of(context).size.height,
                child: Stack(
                  children: [
                    Container(
                      height: 190,
                      width: 380,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          image: DecorationImage(
                            fit: BoxFit.cover,
                            image: AssetImage('lib/assets/images/wisata1.png'),
                          )),
                    ),
                    Positioned(
                        right: 0,
                        left: 0,
                        top: 80,
                        child: FittedBox(
                          fit: BoxFit.fitHeight,
                          child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 20),
                            child: Container(
                              width: 320,
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(15),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.all(15.0),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      'Culture Trip Yogyakarta',
                                      style: Theme.of(context).textTheme.headlineMedium,
                                    ),
                                    TextWisata(textContent: 'Destinasi', listChild: listDestinasi),
                                    TextWisata(textContent: 'Baju Adat', listChild: listBajuAdat),
                                    TextWisata(textContent: 'Penginapan', listChild: listPenginapan),
                                    TextWisata(
                                      textContent: 'Lokasi',
                                      listChild: [
                                        Container(
                                            decoration: BoxDecoration(
                                              borderRadius: BorderRadius.circular(5),
                                              color: Colors.grey,
                                            ),
                                            width: 300,
                                            height: 95,
                                            child: Stack(
                                              children: [
                                                Positioned(
                                                    right: 0,
                                                    bottom: 0,
                                                    child: Padding(
                                                      padding: const EdgeInsets.all(8.0),
                                                      child: Container(
                                                        width: 35,
                                                        height: 35,
                                                        child: IconButton(
                                                          onPressed: () {},
                                                          icon: Icon(
                                                            Icons.zoom_in,
                                                            color: Colors.white,
                                                            size: 20,
                                                          ),
                                                        ),
                                                        decoration: BoxDecoration(
                                                          color: Theme.of(context).primaryColor,
                                                          shape: BoxShape.circle,
                                                        ),
                                                      ),
                                                    ))
                                              ],
                                            ))
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ))
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
