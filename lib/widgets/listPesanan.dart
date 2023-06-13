import 'package:culture_trip/widgets/textWisata.dart';
import 'package:flutter/material.dart';

// ignore: must_be_immutable
class ListPesanan extends StatelessWidget {
  List<Widget> listDestinasi;
  List<Widget> listBajuAdat;
  List<Widget> listPenginapan;
  dynamic tanggal;
  dynamic paket;
  dynamic harga;
  dynamic gambar;

  ListPesanan({
    required this.listDestinasi,
    required this.listBajuAdat,
    required this.listPenginapan,
    this.gambar,
    this.harga,
    this.paket,
    this.tanggal,
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
                child: Column(
                  children: [
                    Container(
                      height: 160,
                      width: 380,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        image: DecorationImage(fit: BoxFit.cover, image: NetworkImage(gambar)),
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    FittedBox(
                      fit: BoxFit.fitHeight,
                      child: Container(
                        width: 370,
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
                                'Culture Trip ${paket}',
                                style: Theme.of(context).textTheme.headlineMedium,
                              ),
                              SizedBox(height: 5),
                              Text(
                                '${tanggal}',
                                style: TextStyle(fontSize: 10, color: Colors.grey, fontWeight: FontWeight.bold),
                              ),
                              TextWisata(textContent: 'Destinasi', listChild: listDestinasi),
                              TextWisata(textContent: 'Baju Adat', listChild: listBajuAdat),
                              TextWisata(textContent: 'Penginapan', listChild: listPenginapan),
                              Divider(
                                height: 25,
                                thickness: 2,
                                color: Color.fromARGB(112, 158, 158, 158),
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    'Total Harga',
                                    style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  Text(
                                    '${harga},00',
                                    style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold,
                                      color: Theme.of(context).primaryColor,
                                    ),
                                  ),
                                ],
                              )
                            ],
                          ),
                        ),
                      ),
                    )
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
