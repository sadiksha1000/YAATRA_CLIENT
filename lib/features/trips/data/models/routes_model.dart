import 'dart:convert';

import '../../domain/entities/routes.dart';
import '../../domain/entities/station.dart';

class RouteModel extends Routes {
  const RouteModel({
    required String rid,
    required Station source,
    required Station destination,
    required List<Station> stops,
  }) : super(
          rid: rid,
          source: source,
          destination: destination,
          stops: stops,
        );

  static const empty = RouteModel(
    rid: '',
    source: Station.empty,
    destination: Station.empty,
    stops: [],
  );

  bool get isEmpty => this == RouteModel.empty;
  bool get isNotEmpty => this != RouteModel.empty;

  Map<String, dynamic> toMap() {
    return {
      '_id': rid,
      'source': source.toMap(),
      'destination': destination.toMap(),
      'stops': stops.map((Station station) => station.toMap()).toList(),
    };
  }

  factory RouteModel.fromMap(Map<String, dynamic> map) {
    return RouteModel(
      rid: map['_id'] ?? '',
      source: Station.fromMap(map['source']),
      destination: Station.fromMap(map['destination']),
      stops: (map['stops'] as List<dynamic>)
          .map((dynamic station) => Station.fromMap(station))
          .toList(),
    );
  }

  String toJson() => json.encode(toMap());

  factory RouteModel.fromJson(String source) =>
      RouteModel.fromMap(json.decode(source)['data']);
}
