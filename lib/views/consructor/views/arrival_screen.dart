import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../../data/model/arrival_info_model.dart';
import '../../../data/model/departure_info_model.dart';
import '../../../data/model/travel_model.dart';

class ArrivalScreen extends StatefulWidget {
  final TravelModel travelModel;
  const ArrivalScreen({super.key, required this.travelModel});

  @override
  _ArrivalScreenState createState() => _ArrivalScreenState();
}

class _ArrivalScreenState extends State<ArrivalScreen> {
  final TextEditingController countryController = TextEditingController();
  final TextEditingController cityController = TextEditingController();
  final TextEditingController airportController = TextEditingController();

  DateTime selectedDate = DateTime.now();
  TimeOfDay selectedTime = TimeOfDay.now();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Constructor Screen')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextFormField(
              controller: countryController,
              decoration: InputDecoration(labelText: 'Country'),
            ),
            TextFormField(
              controller: cityController,
              decoration: InputDecoration(labelText: 'City'),
            ),
            TextFormField(
              controller: airportController,
              decoration: InputDecoration(labelText: 'Airport'),
            ),
            SizedBox(height: 20),
            Row(
              children: [
                Text('Date: ${DateFormat('yyyy-MM-dd').format(selectedDate)}'),
                SizedBox(width: 20),
                ElevatedButton(
                  onPressed: () => _selectDate(context),
                  child: Text('Select Date'),
                ),
              ],
            ),
            SizedBox(height: 10),
            Row(
              children: [
                Text('Time: ${selectedTime.format(context)}'),
                SizedBox(width: 20),
                ElevatedButton(
                  onPressed: () => _selectTime(context),
                  child: Text('Select Time'),
                ),
              ],
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                Navigator.pop(
                  context,
                  TravelModel(
                    departureInfo: DepartureInfoModel(
                      country: countryController.text,
                      city: cityController.text,
                      airport: airportController.text,
                      date: selectedDate,
                      time: selectedTime,
                    ),
                    arrivalInfo: ArrivalInfoModel(
                      country: '',
                      city: '',
                      airport: '',
                      date: DateTime.now(),
                      time: TimeOfDay.now(),
                    ),
                  ),
                );
              },
              child: Text('Save Travel Model'),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: selectedDate,
      firstDate: DateTime.now(),
      lastDate: DateTime(2101),
    );

    if (picked != null && picked != selectedDate) {
      setState(() {
        selectedDate = picked;
      });
    }
  }

  Future<void> _selectTime(BuildContext context) async {
    final TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: selectedTime,
    );

    if (picked != null && picked != selectedTime) {
      setState(() {
        selectedTime = picked;
      });
    }
  }
}
