// ignore_for_file: must_be_immutable

import 'dart:async';

import 'package:culture_trip/models/user.dart';
import 'package:flutter/material.dart';

import 'package:google_maps_flutter/google_maps_flutter.dart';

class MiniMap extends StatefulWidget {
  MiniMap({this.longitude, this.latitude});

  double? longitude;
  double? latitude;

  @override
  State<MiniMap> createState() => _MiniMapState();
}

class _MiniMapState extends State<MiniMap> {
  final Akun = new Users();

  LatLng? currentLocation;

  @override
  Widget build(BuildContext context) {
    final Completer<GoogleMapController> _controller = Completer<GoogleMapController>();
    return GoogleMap(
      zoomControlsEnabled: false,
      markers: {
        Marker(
          markerId: const MarkerId("marker1"),
          position: LatLng(widget.latitude!, widget.longitude!),
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
        target: LatLng(widget.latitude!, widget.longitude!),
        zoom: 19.151926040649414,
      ),
      onMapCreated: (GoogleMapController controller) {
        _controller.complete(controller);
      },
    );
  }
}
