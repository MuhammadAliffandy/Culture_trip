import 'package:culture_trip/models/user.dart';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:geolocator/geolocator.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MapScreen extends StatefulWidget {
  @override
  _MapScreenState createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  final Akun = new Users();
  MapController mapController = MapController();
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
    Akun.upLokasi(position.latitude, position.longitude);
    mapController.move(currentLocation!, 15.0);
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
              return Scaffold(
                body: FlutterMap(
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
                          point: currentLocation != null ? currentLocation! : LatLng(0, 0),
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
                floatingActionButton: FloatingActionButton(
                  onPressed: _getCurrentLocation,
                  tooltip: 'Get Current Location',
                  child: Icon(Icons.my_location),
                  backgroundColor: Theme.of(context).primaryColor,
                ),
              );
            }
          } else {
            return CircularProgressIndicator();
          }
        },
      ),
    );
  }
}
