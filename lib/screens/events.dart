import 'package:flutter/material.dart';

import 'package:sea_splash/models/event.dart';

class EventsScreen extends StatefulWidget {
  const EventsScreen({super.key});

  @override
  State<EventsScreen> createState() {
    return _EventsScreenState();
  }
}

class _EventsScreenState extends State<EventsScreen> {
  final List<Event> _registeredEvents = [
    Event(
      title: 'Booley Bay',
      date: DateTime.now(),
      category: Category.beginner,
    ),
    Event(
      title: 'Tramore',
      date: DateTime.now(),
      category: Category.intermediate,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: const [
          Text('Events list...'),
        ],
      ),
    );
  }
}
