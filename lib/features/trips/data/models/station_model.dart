import 'dart:convert';

import '../../domain/entities/place.dart';
import '../../domain/entities/station.dart';

class StationModel extends Station {
  const StationModel({
    required String sid,
    required Place placeId,
    required String stationName,
    required String message,
  }) : super(
          sid: sid,
          placeId: placeId,
          stationName: stationName,
          message: message,
        );

  static const empty = StationModel(
    sid: '',
    placeId: Place.empty,
    stationName: '',
    message: '',
  );

  bool get isEmpty => this == StationModel.empty;
  bool get isNotEmpty => this != StationModel.empty;

  Map<String, dynamic> toMap() {
    return {
      '_id': sid,
      'placeId': placeId.toMap(),
      'stationName': stationName,
    };
  }

  factory StationModel.fromMap(Map<String, dynamic> map,
      {required String message}) {
    return StationModel(
      sid: map['_id'] ?? '',
      placeId: Place.fromMap(map['placeId']),
      stationName: map['stationName'] ?? '',
      message: message,
    );
  }

  String toJson() => json.encode(toMap());

  // factory StationModel.fromJson(String source) =>
  //     StationModel.fromMap(json.decode(source)['data']);
}
