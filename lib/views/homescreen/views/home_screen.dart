import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:jorney_map/views/homescreen/widgets/empty_flight_banner.dart';
import 'package:jorney_map/views/homescreen/widgets/jetlag_banner.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';
import '../../../data/model/travel_model.dart';
import '../../../util/app_routes.dart';
import '../../consructor/views/departure_screen.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<TravelModel> travelList = [];

  @override
  void initState() {
    super.initState();
    _loadTravelListFromSharedPref();
  }

  Future<void> _loadTravelListFromSharedPref() async {
    final prefs = await SharedPreferences.getInstance();
    final travelListJson = prefs.getString('travelListKey');

    if (travelListJson != null) {
      Iterable decodedList = jsonDecode(travelListJson);
      setState(() {
        travelList =
            decodedList.map((model) => TravelModel.fromJson(model)).toList();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        leading: Text('Flights'),
        actions: [
          TextButton(
              onPressed: () {
                Navigator.of(context).pushNamed(
                  AppRoutes.profile,
                );
              },
              child: Row(
                children: [
                  SvgPicture.asset('assets/icons/settings.svg'),
                  Text('Settings')
                ],
              ))
        ],
      ),
      body: Container(
        child: Column(
          children: [
            travelList.isEmpty
                ? EmptyFlightBanner()
                : ListView.builder(
                    itemCount: travelList.length,
                    itemBuilder: (context, index) {
                      return ListTile(
                        title: Text('Travel ${index + 1}'),
                        subtitle: Text(travelList[index].departureInfo.city),
                        // Display other relevant details here
                      );
                    },
                  ),
            SizedBox(
              height: size.height * 0.01,
            ),
            JetlagBanner(),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => DepartureScreen()),
          ).then((newTravelModel) {
            if (newTravelModel != null) {
              setState(() {
                travelList.add(newTravelModel);
                _saveTravelListToSharedPref();
              });
            }
          });
        },
        child: Icon(Icons.add),
      ),
    );
  }

  Future<void> _saveTravelListToSharedPref() async {
    final prefs = await SharedPreferences.getInstance();
    final encodedList =
        jsonEncode(travelList.map((model) => model.toJson()).toList());
    prefs.setString('travelListKey', encodedList);
  }
}
