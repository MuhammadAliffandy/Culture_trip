import 'package:culture_trip/models/user.dart';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MapProfile extends StatefulWidget {
  MapProfile({this.textContent, this.subTextContent});

  dynamic? textContent;
  dynamic? subTextContent;

  @override
  State<MapProfile> createState() => _MapProfileState();
}

class _MapProfileState extends State<MapProfile> {
  final Akun = new Users();

  LatLng? currentLocation;

  Future<Map<String, dynamic>> getUserData() async {
    SharedPreferences session = await SharedPreferences.getInstance();
    String? key = session.getString('user');
    Map<String, dynamic>? data = await Akun.readUserId(key);

    return data;
  }

  @override
  Widget build(BuildContext context) {
    MapController mapController = MapController();
    return FutureBuilder<Map<String, dynamic>>(
        future: getUserData(),
        builder: (BuildContext context, AsyncSnapshot<Map<String, dynamic>> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          }
          if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          }
          if (!snapshot.hasData) {
            return Center(child: Text('No data'));
          }

          Map<String, dynamic> data = snapshot.data!;
          LatLng currentLocation = data['lokasi']['latitude'] != 0 ? LatLng(data['lokasi']['latitude'], data['lokasi']['longitude']) : LatLng(0, 0);

          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Divider(
                  thickness: 1,
                  height: 5,
                  color: Theme.of(context).primaryColor,
                ),
                SizedBox(
                  height: 15,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 15),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        widget.textContent,
                        style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                      SizedBox(
                        height: 6,
                      ),
                      Text(
                        widget.subTextContent,
                        maxLines: 2,
                        style: TextStyle(
                          fontSize: 14,
                        ),
                      ),
                      SizedBox(
                        height: 6,
                      ),
                      Stack(children: [
                        Container(
                          height: 100,
                          width: MediaQuery.of(context).size.width,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(5),
                            color: Colors.blue,
                          ),
                          child: FlutterMap(
                            mapController: mapController,
                            options: MapOptions(
                              center: currentLocation,
                              zoom: 13.0,
                            ),
                            children: [
                              TileLayer(
                                urlTemplate: 'https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png',
                                subdomains: [
                                  'a',
                                  'b',
                                  'c'
                                ],
                              ),
                              MarkerLayer(
                                markers: [
                                  Marker(
                                    width: 80.0,
                                    height: 80.0,
                                    point: currentLocation,
                                    builder: (ctx) => Container(
                                      child: Icon(
                                        Icons.location_on,
                                        color: Colors.red,
                                        size: 50.0,
                                      ),
                                    ),
                                  ),
                                ],
                              )
                            ],
                          ),
                        ),
                        Positioned(
                          bottom: 0,
                          right: 0,
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Container(
                              width: 40,
                              height: 40,
                              decoration: BoxDecoration(
                                color: Theme.of(context).primaryColor,
                                shape: BoxShape.circle,
                              ),
                              child: IconButton(
                                onPressed: () {
                                  Navigator.pushNamed(context, '/showMapProfil');
                                },
                                icon: Icon(
                                  Icons.my_location_sharp,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ),
                        )
                      ])
                    ],
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
              ],
            ),
          );
        });
  }
}
