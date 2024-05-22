import 'package:jorney_map/data/model/transfer_model.dart';

import 'arrival_info_model.dart';
import 'departure_info_model.dart';

class TravelModel {
  DepartureInfoModel departureInfo;
  ArrivalInfoModel arrivalInfo;
  List<TransferModel> transfers;

  TravelModel({
    required this.departureInfo,
    required this.arrivalInfo,
    this.transfers = const [],
  });

  factory TravelModel.fromJson(Map<String, dynamic> json) {
    return TravelModel(
      departureInfo: DepartureInfoModel.fromJson(json['departureInfo']),
      arrivalInfo: ArrivalInfoModel.fromJson(json['arrivalInfo']),
      transfers: List<TransferModel>.from(
        (json['transfers'] as List)
            .map((transfer) => TransferModel.fromJson(transfer)),
      ),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'departureInfo': departureInfo.toJson(),
      'arrivalInfo': arrivalInfo.toJson(),
      'transfers': transfers.map((transfer) => transfer.toJson()).toList(),
    };
  }
}
