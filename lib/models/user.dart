import 'package:uuid/uuid.dart';

const uuid = Uuid();

enum Category { beginner, novice, intermediate, advanced }

class User {
  User({
    required this.category,
  });

  final Category category;
}
