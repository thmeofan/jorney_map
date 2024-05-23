import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:jorney_map/views/app/widgets/chosen_action_button_widget.dart';
import 'package:jorney_map/views/homescreen/widgets/empty_flight_banner.dart';
import 'package:jorney_map/views/homescreen/widgets/jetlag_banner.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';
import '../../../data/model/travel_model.dart';
import '../../../util/app_routes.dart';
import '../../../util/shared_pref_service.dart';
import '../../consructor/views/departure_screen.dart';
import '../widgets/travel_info_widget.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<TravelModel> travelList = [];
  final SharedPrefsService _sharedPrefsService = SharedPrefsService();

  @override
  void initState() {
    super.initState();
    _loadTravelListFromSharedPref();
  }

  Future<void> _loadTravelListFromSharedPref() async {
    travelList = await _sharedPrefsService.getTravelModelList();
    setState(() {});
  }

  Future<void> _saveTravelListToSharedPref() async {
    await _sharedPrefsService.saveTravelModelList(travelList);
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        leading: Text('Flights'),
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(0.2),
          child: Container(
            height: 0.2,
            decoration: const BoxDecoration(
              border: Border(
                bottom: BorderSide(
                  color: Colors.grey,
                  width: 0.2,
                ),
              ),
            ),
          ),
        ),
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
            ),
          )
        ],
      ),
      body: SingleChildScrollView(
        child: Container(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Your flight'),
              travelList.isEmpty
                  ? EmptyFlightBanner()
                  : ListView.builder(
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                      itemCount: 1,
                      itemBuilder: (context, index) {
                        return TravelInfoWidget(travelModel: travelList[index]);
                      },
                    ),
              SizedBox(
                height: size.height * 0.01,
              ),
              ChosenActionButton(
                text: 'Add new flight',
                onTap: () {
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
              ),
              Text('Jetlag'),
              JetlagBanner(),
            ],
          ),
        ),
      ),
    );
  }
}
