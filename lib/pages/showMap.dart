import 'package:culture_trip/models/user.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

class ShowMapScreen extends StatefulWidget {
  @override
  _ShowMapScreenState createState() => _ShowMapScreenState();
}

class _ShowMapScreenState extends State<ShowMapScreen> {
  final Akun = new Users();
  GoogleMapController? mapController;
  String apiKey = '5b3ce3597851110001cf6248cdab1be06280425f8d59615f41d36b31'; // Ganti dengan API key Anda
  Set<Polyline> polylines = {};
  Set<Marker> markers = {};
  double? startLat;
  double? startLong;
  double? endLat;
  double? endLong;

  @override
  void initState() {
    super.initState();
    getDirections();
  }

  @override
  Widget build(BuildContext context) {
    final Map<String, dynamic>? arguments = ModalRoute.of(context)?.settings.arguments as Map<String, dynamic>?;

    endLat = arguments?['latitude'];
    endLong = arguments?['longitude'];
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
              return GoogleMap(
                mapType: MapType.hybrid,
                onMapCreated: (controller) {
                  mapController = controller;
                },
                initialCameraPosition: CameraPosition(
                  target: LatLng(startLat ?? 0.toDouble(), startLong ?? 0.toDouble()), // Koordinat awal
                  zoom: 12,
                ),
                polylines: polylines,
                markers: markers,
              );
            }
          } else {
            return CircularProgressIndicator();
          }
        },
      ),
    );
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

  getMapUser() async {
    SharedPreferences session = await SharedPreferences.getInstance();
    String? key = session.getString('user');
    Map<String, dynamic>? data = await Akun.readUserId(key);
    setState(() {
      startLat = data['lokasi']['latitude'] != 0 ? data['lokasi']['latitude'] : 0.toDouble();
      startLong = data['lokasi']['laongitude'] != 0 ? data['lokasi']['longitude'] : 0.toDouble();
    });
  }

  void getDirections() async {
    await getMapUser();

    String url = 'https://api.openrouteservice.org/v2/directions/driving-car?api_key=$apiKey&start=$startLong,$startLat&end=$endLong,$endLat';

    final response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      List<LatLng> polylineCoordinates = decodePolyline(data['features'][0]['geometry']['coordinates']);
      LatLng start = LatLng(polylineCoordinates.first.latitude, polylineCoordinates.first.longitude);
      LatLng end = LatLng(polylineCoordinates.last.latitude, polylineCoordinates.last.longitude);

      setState(() {
        polylines.add(
          Polyline(
            polylineId: PolylineId('route'),
            points: polylineCoordinates,
            color: Theme.of(context).primaryColor,
            width: 3,
          ),
        );
        markers.add(
          Marker(
            infoWindow: InfoWindow(title: 'Lokasi Anda'),
            markerId: MarkerId('start'),
            position: start,
            icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueGreen),
          ),
        );
        markers.add(
          Marker(
            infoWindow: InfoWindow(title: 'Lokasi Tujuan'),
            markerId: MarkerId('end'),
            position: end,
            icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueRed),
          ),
        );
      });
    }
  }

  List<LatLng> decodePolyline(List<dynamic> encoded) {
    List<LatLng> polylineCoordinates = [];

    for (int i = 0; i < encoded.length; i++) {
      double lat = encoded[i][1];
      double lng = encoded[i][0];
      polylineCoordinates.add(LatLng(lat, lng));
    }

    return polylineCoordinates;
  }
}
