import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:sea_splash/models/place.dart';

class MapOverviewScreen extends StatefulWidget {
  const MapOverviewScreen({
    super.key,
    this.places = const [],
  });

  final List<Place> places;

  @override
  State<MapOverviewScreen> createState() {
    return _MapOverviewScreenState();
  }
}

class _MapOverviewScreenState extends State<MapOverviewScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.onPrimary,
        title: Text('Map of Swim Spots',
            style: TextStyle(color: Theme.of(context).colorScheme.primary)),
      ),
      body: GoogleMap(
        initialCameraPosition: const CameraPosition(
          target: LatLng(52.4, -6.8), // Center the map initially
          zoom: 9,
        ),
        markers: Set<Marker>.from(
          widget.places.map((place) => Marker(
                markerId: MarkerId(place.id),
                position:
                    LatLng(place.location.latitude, place.location.longitude),
                infoWindow: InfoWindow(title: place.title),
                
              )),
        ),
      ),
    );
  }
}
