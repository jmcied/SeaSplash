import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:uuid/uuid.dart';

const uuid = Uuid();
final dateFormatter = DateFormat.yMd();
final hourMinuteFormat = DateFormat('hh:mm a');

enum Category { beginner, novice, intermediate, advanced }

class Event {
  Event({
    required this.title,
    required this.location,
    required this.date,
    required this.time,
    //required this.category,
  }) : id = uuid.v4();

  final String id;
  final String title;
  final String location;
  final DateTime date;
  final TimeOfDay time;
  //final Category category;

  String get formattedDate {
    return dateFormatter.format(date);
  }

  String get formattedTime {
    return hourMinuteFormat.format(date);
  }
}
