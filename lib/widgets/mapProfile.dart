import 'dart:async';

import 'package:culture_trip/models/user.dart';
import 'package:flutter/material.dart';

import 'package:google_maps_flutter/google_maps_flutter.dart';

import 'package:shared_preferences/shared_preferences.dart';

class MapProfile extends StatefulWidget {
  MapProfile({this.textContent, this.subTextContent});

  dynamic textContent;
  dynamic subTextContent;

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
    final Completer<GoogleMapController> _controller = Completer<GoogleMapController>();
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
                          child: GoogleMap(
                            zoomControlsEnabled: false,
                            markers: {
                              Marker(
                                markerId: const MarkerId("marker1"),
                                position: currentLocation != null ? currentLocation! : LatLng(0, 0),
                                draggable: true,
                                onDragEnd: (value) {
                                  // value is the new position
                                },
                                // To do: custom marker icon
                              ),
                            },
                            mapType: MapType.hybrid,
                            initialCameraPosition: CameraPosition(
                              bearing: 192.8334901395799,
                              target: currentLocation != null ? currentLocation! : LatLng(0, 0),
                              zoom: 19.151926040649414,
                            ),
                            onMapCreated: (GoogleMapController controller) {
                              _controller.complete(controller);
                            },
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
