import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../data/model/jetlag_model.dart';

class JetlagConstructorScreen extends StatefulWidget {
  @override
  _JetlagConstructorScreenState createState() =>
      _JetlagConstructorScreenState();
}

class _JetlagConstructorScreenState extends State<JetlagConstructorScreen> {
  late SharedPreferences _prefs;
  late TimeOfDay selectedTime = TimeOfDay.now();

  @override
  void initState() {
    super.initState();
    _initSharedPreferences();
  }

  void _initSharedPreferences() async {
    _prefs = await SharedPreferences.getInstance();
  }

  void saveJetlagInfo(
      String homeCountry, String destinationCountry, TimeOfDay time) {
    JetlagModel jetlag = JetlagModel(
        homeCountry: homeCountry,
        destinationCountry: destinationCountry,
        time: time);

    _prefs.setString('homeCountry', jetlag.homeCountry);
    _prefs.setString('destinationCountry', jetlag.destinationCountry);
    _prefs.setString('time', jetlag.time.format(context));
  }

  void _selectTime(BuildContext context) async {
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

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Scaffold(
      appBar: AppBar(
        title: Text('Enter Jetlag Info'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(
              decoration: InputDecoration(labelText: 'Home Country'),
            ),
            SizedBox(height: 10),
            TextField(
              decoration: InputDecoration(labelText: 'Destination Country'),
            ),
            SizedBox(height: 10),
            Container(
              width: size.width * 0.43,
              height: size.height * 0.06,
              decoration: BoxDecoration(
                color: Colors.black.withOpacity(0.06),
                borderRadius: BorderRadius.circular(12),
                border: Border.all(
                  color: Colors.grey,
                  width: 0.5,
                ),
              ),
              child: InkWell(
                onTap: () => _selectTime(context),
                child: Row(
                  children: [
                    SizedBox(width: 5),
                    Icon(Icons.access_time),
                    SizedBox(width: 10),
                    Text(' ${selectedTime.format(context)}'),
                  ],
                ),
              ),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                String homeCountry =
                    ''; // Get the value of home country from TextField
                String destinationCountry =
                    ''; // Get the value of destination country from TextField
                saveJetlagInfo(homeCountry, destinationCountry, selectedTime);
              },
              child: Text('Save'),
            ),
          ],
        ),
      ),
    );
  }
}
