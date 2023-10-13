// Overall, this widget provides a user interface for selecting and confirming a date,
// with error handling for cases where no date is selected.
//It's a reusable component that can be used in various Flutter applications for date selection tasks.

import 'package:flutter/material.dart';
import 'package:clinician_app/widgets/patient_overview.dart';
// import 'package:intl/intl.dart';

class CalendarDate extends StatefulWidget {
  //The CalendarDate widget is a stateful widget, that has mutable state.
  const CalendarDate({super.key, required this.onChooseDate});
//It takes a parameter named onChooseDate, which is a function that takes a DateTime parameter.

  final Function(DateTime selectedDate)
      onChooseDate; //fonction which gives us a date

  @override
  State<CalendarDate> createState() {
    return _CalendarDate();
  }
}

DateTime?
    _selectedDate; //_selectedDate is a private variable that holds the currently selected date.

class _CalendarDate extends State<CalendarDate> {
  // Private class _CalendarDate, which extends State<CalendarDate>.
//This is where the mutable state and logic for handling date selection are implemented.

  void _presentDatePicker() async {
    //The _presentDatePicker method is used to display a date picker dialog for selecting a date.
    final now = DateTime.now(); // today date
    final firstDate = DateTime(now.year - 1, now.month,
        now.day); // date from which we can choose a date, present date minus 1 year

    final pickedDate = await showDatePicker(
      // show a calendar where we can pick a date with last date, today date and firstDate
      context: context,
      initialDate: now,
      firstDate: firstDate,
      lastDate: now,
    );
    setState(
      // set state benefits from the StateFul widget of this class
      () {
        _selectedDate = pickedDate; // show the date picked once it's done
      },
    );
  }

  void _submitDateData() {
    if (_selectedDate == null) {
      // if statement, if no date selected show an error message
      showDialog(
        // show a window with some error message
        context: context,
        builder: (ctx) => AlertDialog(
          title: const Text('Invalid date'), // text of the error message
          content:
              const Text('Please choose a date'), // text of the error message
          actions: [
            TextButton(
              // textbutton allowing us to close this window
              onPressed: () {
                Navigator.pop(ctx); // close that window when 'ok' is pressed
              },
              child: const Text('Okay'),
            )
          ],
        ),
      );
      return;
    }
// If _selectedDate is not null, it displays the selected date as a string.
    widget.onChooseDate(
      DateTime(
        _selectedDate!.year,
        _selectedDate!.month,
        _selectedDate!.day,
      ),
    );
    Navigator.pop(
        context); // close the window after 'ok' is pressed in the elevated button

    dayChoose = DateTime(
      _selectedDate!.year,
      _selectedDate!.month,
      _selectedDate!.day,
    );
  }

  @override
  Widget build(BuildContext context) {
    //The build method defines the widget's UI structure
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Expanded(
        //this widget expanded allowes the widgets below to take all the place needed
        child: Column(
          children: [
            Text(
              _selectedDate == null // if no date selected
                  ? 'No date selected' // show this message
                  : _selectedDate.toString(), // else the date selected
            ),
            IconButton(
              onPressed:
                  _presentDatePicker, // go to the method _presentDatePicker wich allow us to pick a date
              icon:
                  const Icon(Icons.calendar_month), // type of the icon selected
            ),
            Expanded(
              child: Row(
                mainAxisAlignment:
                    MainAxisAlignment.center, // center along the main axis
                crossAxisAlignment:
                    CrossAxisAlignment.center, // center along the cross axis
                children: [
                  TextButton(
                    onPressed: () {
                      Navigator.pop(
                          context); // closes the date picker dialog without selecting a date.
                    },
                    child: const Text('Cancel'),
                  ),
                  ElevatedButton(
                    // allow us to validate data when 'ok' is pressed
                    onPressed:
                        _submitDateData, // go to the method _submitDateDate above to validate ot not the date chosen
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
