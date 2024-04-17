import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sea_splash/models/place.dart';

import 'package:sea_splash/providers/user_places.dart';
import 'package:sea_splash/screens/add_place.dart';
import 'package:sea_splash/screens/map_overview.dart';
import 'package:sea_splash/widgets/main_drawer.dart';
import 'package:sea_splash/widgets/places_list.dart';

class PlacesScreen extends ConsumerStatefulWidget {
  const PlacesScreen({super.key});

  @override
  ConsumerState<PlacesScreen> createState() {
    return _PlacesScreenState();
  }
}

class _PlacesScreenState extends ConsumerState<PlacesScreen> {
  //late Future<void> _placesFuture;

  @override
  void initState() {
    super.initState();
    //_placesFuture = ref.read(userPlacesProvider.notifier).loadPlaces();
  }

  @override
  Widget build(BuildContext context) {
    //final userPlaces = ref.watch(userPlacesProvider);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.onPrimary,
        title: Text(
          'Swim Spots',
          style: TextStyle(color: Theme.of(context).colorScheme.primary),
        ),
        actions: [
          //if(_isAdmin)
          // IconButton(
          //   icon: Icon(
          //     Icons.map,
          //     color: Theme.of(context).colorScheme.primary,
          //   ),
          //   onPressed: () {
          //     Navigator.of(context).push(
          //       MaterialPageRoute(
          //         builder: (ctx) => MapOverviewScreen(places: userPlaces),
          //       ),
          //     );
          //   },
          // ),
          IconButton(
            icon: Icon(
              Icons.add,
              color: Theme.of(context).colorScheme.primary,
            ),
            onPressed: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (ctx) => const AddPlaceScreen(),
                ),
              );
            },
          ),
          IconButton(
            onPressed: () {
              FirebaseAuth.instance.signOut();
            },
            icon: Icon(
              Icons.exit_to_app,
              color: Theme.of(context).colorScheme.primary,
            ),
          )
        ],
      ),
      drawer: const MainDrawer(),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: StreamBuilder(
          stream: FirebaseFirestore.instance
              .collection('swimspots')
              //.orderBy('title', descending: false)
              .snapshots(),
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

            return PlacesList(
                places: loadedPlaces); // Pass loadedPlaces to PlacesList
          },
        ),
      ),
    );
  }
}

          // final loadedPlaces = swimSnapshots.data!.docs;

          // return ListView.builder(
          //   itemCount: loadedPlaces.length,
          //   itemBuilder: (ctx, index) => Text(
          //     loadedPlaces[index].data()['title'],
          //   ),
          // );


          // FutureBuilder(
          //   future: _placesFuture,
          //   builder: (context, snapshot) =>
          //       snapshot.connectionState == ConnectionState.waiting
          //           ? const Center(
          //               child: CircularProgressIndicator(),
          //             )
          //           : PlacesList(
          //               places: userPlaces,
          //             ),
          // ),


