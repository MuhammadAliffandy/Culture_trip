import 'dart:async';

import 'package:culture_trip/models/user.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MapSample extends StatefulWidget {
  const MapSample({super.key});

  @override
  State<MapSample> createState() => MapSampleState();
}

class MapSampleState extends State<MapSample> {
  final Akun = new Users();
  final Completer<GoogleMapController> _controller = Completer<GoogleMapController>();

// SET UP ULANG
  LatLng? currentLocation;

  getMapUser() async {
    SharedPreferences session = await SharedPreferences.getInstance();
    String? key = session.getString('user');
    Map<String, dynamic>? data = await Akun.readUserId(key);
    setState(() {
      currentLocation = data['lokasi']['latitude'] != 0 ? LatLng(data['lokasi']['latitude'], data['lokasi']['longitude']) : LatLng(0.toDouble(), 0.toDouble());
    });
  }

  void _getCurrentLocation() async {
    Position position = await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
    setState(() {
      currentLocation = LatLng(position.latitude, position.longitude);
    });
    List<Placemark> newAlamat = await placemarkFromCoordinates(position.latitude, position.longitude);
    Placemark place = newAlamat[0];

    String? city = place.locality;
    String? country = place.country;
    Akun.upLokasi(position.latitude, position.longitude, '$city , $country ');
  }

  Future<bool> checkLocationPermission() async {
    LocationPermission permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.always || permission == LocationPermission.whileInUse) {
      return true;
    } else if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.always || permission == LocationPermission.whileInUse) {
        return true;
      }
    }
    return false;
  }

  @override
  void initState() {
    super.initState();
    getMapUser();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        floatingActionButton: FloatingActionButton(
          onPressed: _getCurrentLocation,
          child: Icon(Icons.my_location),
          backgroundColor: Theme.of(context).primaryColor,
        ),
        appBar: AppBar(
          backgroundColor: Theme.of(context).primaryColor,
          leading: IconButton(
              onPressed: () {
                Navigator.popAndPushNamed(context, '/profil');
              },
              icon: Icon(
                Icons.arrow_back,
                color: Colors.white,
                size: 30,
              )),
          elevation: 0,
        ),
        body: FutureBuilder<bool>(
            future: checkLocationPermission(),
            builder: (BuildContext context, AsyncSnapshot<bool> snapshot) {
              if (snapshot.connectionState == ConnectionState.done) {
                if (snapshot.hasError) {
                  return Text('Error: ${snapshot.error}');
                } else if (snapshot.data == null) {
                  return Text('Please grant location permission');
                } else {
                  return GoogleMap(
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
                  );
                }
              } else {
                return Center(child: CircularProgressIndicator());
              }
            }));
  }
}
