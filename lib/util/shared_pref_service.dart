import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

import '../data/model/travel_model.dart';

class SharedPreferencesService {
  static const String travelModelKey = 'travelModel';

  Future<void> saveTravelModel(TravelModel travelModel) async {
    final prefs = await SharedPreferences.getInstance();
    final travelModelJson = jsonEncode(travelModel.toJson());
    await prefs.setString(travelModelKey, travelModelJson);
  }

  Future<TravelModel?> getTravelModel() async {
    final prefs = await SharedPreferences.getInstance();
    final travelModelJson = prefs.getString(travelModelKey);
    if (travelModelJson != null) {
      final travelModelMap = jsonDecode(travelModelJson);
      return TravelModel.fromJson(travelModelMap);
    }
    return null;
  }
}
