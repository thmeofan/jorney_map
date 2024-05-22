import 'package:flutter_bloc/flutter_bloc.dart';

import '../../data/model/travel_model.dart';
import '../../util/shared_pref_service.dart';

class TravelCubit extends Cubit<TravelModel?> {
  TravelCubit() : super(null);

  final _sharedPrefService = SharedPreferencesService();

  void loadTravelModel() async {
    final travelModel = await _sharedPrefService.getTravelModel();
    emit(travelModel);
  }

  void saveTravelModel(TravelModel travelModel) async {
    await _sharedPrefService.saveTravelModel(travelModel);
    emit(travelModel);
  }
}
