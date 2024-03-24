import 'package:uuid/uuid.dart';

const uuid = Uuid();

enum Category { beginner, novice, intermediate, advanced }

class Event {
  Event({
    required this.title,
    required this.date,
    required this.category,
  }) : id = uuid.v4();

  final String id;
  final String title;
  final DateTime date;
  final Category category;
}
