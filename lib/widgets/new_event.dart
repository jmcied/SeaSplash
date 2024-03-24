import 'package:flutter/material.dart';
import 'package:sea_splash/models/event.dart';

class NewEvent extends StatefulWidget {
  const NewEvent({super.key});

  @override
  State<StatefulWidget> createState() {
    return _NewEventState();
  }
}

class _NewEventState extends State<NewEvent> {
  final _titleController = TextEditingController();
  final _locationController = TextEditingController();
  DateTime? _selectedDate;
  TimeOfDay? _selectedTime;

  void _datePicker() async {
    final now = DateTime.now();
    final lastDate = DateTime(now.year, now.month + 2, now.day);
    final pickedDate = await showDatePicker(
      context: context,
      initialDate: now,
      firstDate: now,
      lastDate: lastDate,
    );
    setState(() {
      _selectedDate = pickedDate;
    });
  }

  void _timePicker() async {
    final now = TimeOfDay.now();
    final pickedTime = await showTimePicker(
      context: context,
      initialTime: now,
    );
    setState(() {
      _selectedTime = pickedTime;
    });
  }

  @override
  void dispose() {
    _titleController.dispose();
    _locationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        children: [
          TextField(
            controller: _titleController,
            maxLength: 50,
            decoration: const InputDecoration(
              label: Text('Title'),
            ),
          ),
          TextField(
            controller: _locationController,
            maxLength: 50,
            decoration: const InputDecoration(
              label: Text('Location'),
            ),
          ),
          Row(
            children: [
              Expanded(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      _selectedDate == null
                          ? 'No Selected Date'
                          : dateFormatter.format(_selectedDate!),
                    ),
                    IconButton(
                      onPressed: _datePicker,
                      icon: const Icon(Icons.calendar_month),
                    ),
                    const SizedBox(width: 16),
                    Text(
                      _selectedTime == null
                          ? 'No Selected Time'
                          : hourMinuteFormat.format(
                              DateTime(0, 1, 1, _selectedTime!.hour,
                                  _selectedTime!.minute),
                            ),
                    ),
                    IconButton(
                      onPressed: _timePicker,
                      icon: const Icon(Icons.watch),
                    ),
                  ],
                ),
              ),
            ],
          ),
          Row(
            children: [
              TextButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: const Text('Cancel'),
              ),
              ElevatedButton(
                onPressed: () {
                  print(_titleController.text);
                  print(_locationController.text);
                },
                child: const Text(
                  'Save Event',
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}
