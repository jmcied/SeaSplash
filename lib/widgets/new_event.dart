import 'package:flutter/material.dart';

class NewEvent extends StatefulWidget {
  const NewEvent({super.key});

  @override
  State<StatefulWidget> createState() {
    return _NewEventState();
  }
}

class _NewEventState extends State<NewEvent> {
  var _enteredTitle = '';

  void _saveTitleInput(String inputValue) {
    _enteredTitle = inputValue;
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        children: [
          TextField(
            onChanged: _saveTitleInput,
            maxLength: 50,
            decoration: const InputDecoration(
              label: Text('Title'),
            ),
          ),
          Row(
            children: [
              ElevatedButton(
                  onPressed: () {
                    print(_enteredTitle);
                  },
                  child: const Text(
                    'Save Event',
                  ))
            ],
          )
        ],
      ),
    );
  }
}
