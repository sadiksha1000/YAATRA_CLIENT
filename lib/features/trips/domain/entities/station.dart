import 'package:equatable/equatable.dart';
import 'place.dart';

class Station extends Equatable {
  final String sid;
  final Place placeId;
  final String stationName;
  final String message;

  const Station(
      {required this.sid,
      required this.placeId,
      required this.stationName,
      required this.message});

  static const empty = Station(
    sid: '',
    placeId: Place.empty,
    stationName: '',
    message: '',
  );

  bool get isEmpty => this == Station.empty;
  bool get isNotEmpty => this != Station.empty;

  factory Station.fromMap(Map<String, dynamic> map) {
    return Station(
      sid: map['_id'] ?? '',
      placeId: Place.fromMap(map['placeId']),
      stationName: map['stationName'] ?? '',
      message: map['message'] ?? '',
    );
  }

  Map<String, dynamic> toMap() {
    return {
      '_id': sid,
      'placeId': placeId.toMap(),
      'stationName': stationName,
      'message': message,
    };
  }

  @override
  List<Object?> get props => [sid, placeId, stationName, message];
}
