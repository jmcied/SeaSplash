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
  LatLng? _pickedLocation;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            backgroundColor: Theme.of(context).colorScheme.onPrimary,
            title: Text(
              widget.isSelecting ? 'Pick your location' : 'SwimSpot Location',
              style: TextStyle(color: Theme.of(context).colorScheme.primary),
            ),
            actions: [
              if (widget.isSelecting)
                IconButton(
                  icon: Icon(Icons.save,
                      color: Theme.of(context).colorScheme.primary),
                  onPressed: () {
                    Navigator.of(context).pop(_pickedLocation);
                  },
                ),
            ]),
        body: GoogleMap(
          onTap: !widget.isSelecting
              ? null
              : (position) {
                  setState(() {
                    _pickedLocation = position;
                  });
                },
          initialCameraPosition: CameraPosition(
            target: LatLng(
              widget.location.latitude,
              widget.location.longitude,
            ),
            zoom: 14,
          ),
          markers: (_pickedLocation == null && widget.isSelecting)
              ? {}
              : {
                  Marker(
                    markerId: const MarkerId('m1'),
                    position: _pickedLocation ??
                        LatLng(
                          //_pickedLocation != null? _pickedLocation! : LatLng
                          widget.location.latitude,
                          widget.location.longitude,
                        ),
                  ),
                },
        ));
  }
}
