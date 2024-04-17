import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:sea_splash/models/place.dart';
import 'package:sea_splash/widgets/main_drawer.dart';

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
      drawer: const MainDrawer(),
      body: StreamBuilder(
        stream: FirebaseFirestore.instance.collection('swimspots').snapshots(),
        builder: (ctx, swimSnapshots) {
          if (swimSnapshots.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          if (!swimSnapshots.hasData || swimSnapshots.data!.docs.isEmpty) {
            return const Center(
              child: Text('No swim spots found.'),
            );
          }
          if (swimSnapshots.hasError) {
            return const Center(
              child: Text('Something went wrong...'),
            );
          }
          final loadedPlaces = swimSnapshots.data!.docs.map((doc) {
            final data = doc.data();
            return Place(
              id: data['id'],
              title: data['title'],
              image: data['image'],
              location: PlaceLocation(
                latitude: data['lat'],
                longitude: data['lng'],
                address: data['address'],
              ),
            );
          }).toList();
          return GoogleMap(
            initialCameraPosition: const CameraPosition(
              target: LatLng(52.4, -6.8), // Center the map initially
              zoom: 9,
            ),
            markers: Set<Marker>.from(
              loadedPlaces.map((place) => Marker(
                    markerId: MarkerId(place.id),
                    position: LatLng(
                        place.location.latitude, place.location.longitude),
                    infoWindow: InfoWindow(title: place.title),
                  )),
            ),
          );
        },
      ),
    );
  }
}
