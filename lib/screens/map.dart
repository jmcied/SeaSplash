import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:sea_splash/models/place.dart';

class MapScreen extends StatefulWidget {
  const MapScreen({
    super.key,
    this.location = const PlaceLocation(
      latitude: 52.221,
      longitude: -6.93,
      address: '',
    ),
    this.isSelecting = true,
  });

  final PlaceLocation location;
  final bool isSelecting;

  @override
  State<MapScreen> createState() {
    return _MapScreenState();
  }
}

class _MapScreenState extends State<MapScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            title: Text(
                widget.isSelecting ? 'Pick your location' : 'Your Location'),
            actions: [
              if (widget.isSelecting)
                IconButton(
                  icon: const Icon(Icons.save),
                  onPressed: () {},
                ),
            ]),
        body: GoogleMap(
          initialCameraPosition: CameraPosition(
            target: LatLng(
              widget.location.latitude,
              widget.location.longitude,
            ),
            zoom: 16,
          ),
          markers: {
            Marker(
              markerId: const MarkerId('m1'),
              position: LatLng(
                widget.location.latitude,
                widget.location.longitude,
              ),
            ),
          },
        ));
  }
}
