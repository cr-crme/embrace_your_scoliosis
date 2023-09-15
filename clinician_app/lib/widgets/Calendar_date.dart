import 'package:flutter/material.dart';
import 'package:clinician_app/widgets/patient_overview.dart';
// import 'package:intl/intl.dart';

class CalendarDate extends StatefulWidget {
  const CalendarDate({super.key, required this.onChooseDate});

  final Function(DateTime selectedDate)
      onChooseDate; //fonction donnant une date

  @override
  State<CalendarDate> createState() {
    return _CalendarDate();
  }
}

DateTime? _selectedDate;

class _CalendarDate extends State<CalendarDate> {
  void _presentDatePicker() async {
    final now = DateTime.now();
    final firstDate = DateTime(now.year - 1, now.month, now.day);

    final pickedDate = await showDatePicker(
      context: context,
      initialDate: now,
      firstDate: firstDate,
      lastDate: now,
    );
    setState(
      () {
        _selectedDate = pickedDate;
      },
    );
  }

  void _submitDateData() {
    if (_selectedDate == null) {
      //message d'erreur disant que l'on n'a pas choisi de date
      showDialog(
        context: context,
        builder: (ctx) => AlertDialog(
          title: const Text('Invalid date'),
          content: const Text('Please choose a date'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(ctx);
              },
              child: const Text('Okay'),
            )
          ],
        ),
      );
      return;
    }

    widget.onChooseDate(
      DateTime(
        _selectedDate!.year,
        _selectedDate!.month,
        _selectedDate!.day,
      ),
    );
    dayChoose = DateTime(
      _selectedDate!.year,
      _selectedDate!.month,
      _selectedDate!.day,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Expanded(
        child: Column(
          children: [
            Text(
              _selectedDate == null
                  ? 'No date selected'
                  : _selectedDate.toString(),
            ),
            IconButton(
              onPressed: _presentDatePicker,
              icon: const Icon(Icons.calendar_month),
            ),
            Expanded(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  TextButton(
                    onPressed: () {
                      Navigator.pop(
                          context); //enlève la page calendrier de l'écran
                    },
                    child: const Text('Cancel'),
                  ),
                  ElevatedButton(
                    onPressed: _submitDateData,
                    child: const Text('ok'),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
