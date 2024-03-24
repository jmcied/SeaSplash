import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import 'package:sea_splash/models/event.dart';
import 'package:sea_splash/widgets/events_list/events_list.dart';
import 'package:sea_splash/widgets/new_event.dart';

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
      title: 'Quick Dip',
      location: 'Booley Bay',
      date: DateTime.now(),
      category: Category.beginner,
    ),
    Event(
      title: 'Fun in the sun',
      location: 'Tramore',
      date: DateTime.now(),
      category: Category.intermediate,
    ),
  ];

  void _openAddEventOverlay() {
    showModalBottomSheet(
      backgroundColor: Colors.white,
      context: context,
      builder: (ctx) => const NewEvent(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.onPrimary,
        title: Text(
          'Swim Meetups',
          style: TextStyle(color: Theme.of(context).colorScheme.primary),
        ),
        actions: [
          IconButton(
            icon: Icon(
              Icons.add,
              color: Theme.of(context).colorScheme.primary,
            ),
            onPressed: _openAddEventOverlay,
          ),
        ],
      ),
      body: Column(
        children: [
          Expanded(
            child: EventsList(
              events: _registeredEvents,
            ),
          )
        ],
      ),
    );
  }
}
