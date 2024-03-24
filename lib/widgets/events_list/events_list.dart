import 'package:flutter/material.dart';

import 'package:sea_splash/models/event.dart';
import 'package:sea_splash/models/place.dart';
import 'package:sea_splash/widgets/events_list/event_item.dart';

class EventsList extends StatelessWidget {
  const EventsList({
    super.key,
    required this.events,
    //required this.places,
  });

  final List<Event> events;
  //final List<Place> places;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        itemCount: events.length,
        itemBuilder: (ctx, index) => EventItem(events[index]));
  }
}
