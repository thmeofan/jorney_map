import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:jorney_map/views/app/widgets/input_widget.dart';

import '../../../data/model/arrival_info_model.dart';
import '../../../data/model/departure_info_model.dart';
import '../../../data/model/travel_model.dart';
import 'arrival_screen.dart';

class DepartureScreen extends StatefulWidget {
  @override
  _DepartureScreenState createState() => _DepartureScreenState();
}

class _DepartureScreenState extends State<DepartureScreen> {
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
            Text('Departure from origin'),
            InputWidget(
              controller: countryController,
              labelText: 'Country of departure',
            ),
            InputWidget(
              controller: cityController,
              labelText: 'City of departure',
            ),
            InputWidget(
              controller: airportController,
              labelText: 'Airport name',
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
                TravelModel travelModel = TravelModel(
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
                );
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) =>
                        ArrivalScreen(travelModel: travelModel),
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
