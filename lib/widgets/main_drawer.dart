import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:sea_splash/screens/auth.dart';
import 'package:sea_splash/screens/map.dart';
import 'package:sea_splash/screens/map_overview.dart';
import 'package:sea_splash/screens/places.dart';

class MainDrawer extends StatelessWidget {
  const MainDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: [
          DrawerHeader(
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  Theme.of(context).colorScheme.primaryContainer,
                  Theme.of(context)
                      .colorScheme
                      .primaryContainer
                      .withOpacity(0.5)
                ],
              ),
            ),
            child: Row(
              children: [
                Icon(Icons.waves,
                    size: 50, color: Theme.of(context).colorScheme.primary),
                const SizedBox(
                  width: 16,
                ),
                Text(
                  "SeaSplash",
                  style: Theme.of(context).textTheme.titleLarge!.copyWith(
                        color: Theme.of(context).colorScheme.primary,
                      ),
                ),
              ],
            ),
          ),
          ListTile(
            leading: Icon(
              Icons.water_drop,
              color: Theme.of(context).colorScheme.onBackground,
            ),
            title: Text(
              "Swim List",
              style: Theme.of(context).textTheme.titleSmall!.copyWith(
                    color: Theme.of(context).colorScheme.onBackground,
                    fontSize: 24,
                  ),
            ),
            onTap: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (ctx) => const PlacesScreen(),
                ),
              );
            },
          ),
          ListTile(
            leading: Icon(
              Icons.map_outlined,
              color: Theme.of(context).colorScheme.onBackground,
            ),
            title: Text(
              "Swim Locations",
              style: Theme.of(context).textTheme.titleSmall!.copyWith(
                    color: Theme.of(context).colorScheme.onBackground,
                    fontSize: 24,
                  ),
            ),
            onTap: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (ctx) => const MapOverviewScreen(),
                ),
              );
            },
          ),
          // ListTile(
          //   leading: Icon(
          //     Icons.exit_to_app,
          //     color: Theme.of(context).colorScheme.onBackground,
          //   ),
          // title: Text(
          //   "Log out",
          //   style: Theme.of(context).textTheme.titleSmall!.copyWith(
          //         color: Theme.of(context).colorScheme.onBackground,
          //         fontSize: 24,
          //       ),
          // ),
          // onTap: () {
          //   //FirebaseAuth.instance.signOut();
          //   Navigator.of(context).push(
          //     MaterialPageRoute(
          //       builder: (ctx) => const AuthScreen(),
          //     ),
          //   );
          // },
          //),
        ],
      ),
    );
  }
}
