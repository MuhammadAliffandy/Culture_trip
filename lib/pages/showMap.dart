import 'dart:async';

import 'package:culture_trip/models/user.dart';
import 'package:flutter/material.dart';

import 'package:google_maps_flutter/google_maps_flutter.dart';

import 'package:geolocator/geolocator.dart';

class ShowMapScreen extends StatefulWidget {
  @override
  _ShowMapScreenState createState() => _ShowMapScreenState();
}

class _ShowMapScreenState extends State<ShowMapScreen> {
  final Akun = new Users();

  final Completer<GoogleMapController> _controller = Completer<GoogleMapController>();

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
  Widget build(BuildContext context) {
    final Map<String, dynamic>? arguments = ModalRoute.of(context)?.settings.arguments as Map<String, dynamic>?;

    var latitude = arguments?['latitude'];
    var longitude = arguments?['longitude'];
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).primaryColor,
        leading: IconButton(
            onPressed: () {
              Navigator.popAndPushNamed(context, '/Lokasi');
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
              return Scaffold(
                  body: GoogleMap(
                zoomControlsEnabled: false,
                markers: {
                  Marker(
                    markerId: const MarkerId("marker1"),
                    position: LatLng(latitude!, longitude!),
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
                  target: LatLng(latitude!, longitude!),
                  zoom: 19.151926040649414,
                ),
                onMapCreated: (GoogleMapController controller) {
                  _controller.complete(controller);
                },
              ));
            }
          } else {
            return CircularProgressIndicator();
          }
        },
      ),
    );
  }
}
