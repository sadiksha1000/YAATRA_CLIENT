import 'package:equatable/equatable.dart';
import 'station.dart';

class Routes extends Equatable {
  final String rid;
  final Station source;
  final Station destination;
  final List<Station> stops;

  const Routes({
    required this.rid,
    required this.source,
    required this.destination,
    required this.stops,
  });

  static const empty = Routes(
    rid: '',
    source: Station.empty,
    destination: Station.empty,
    stops: [],
  );

  factory Routes.fromMap(Map<String, dynamic> map) {
    return Routes(
      rid: map['_id'] ?? '',
      source: Station.fromMap(map['source']),
      destination: Station.fromMap(map['destination']),
      stops: (map['stops'] as List<dynamic>)
          .map((e) => Station.fromMap(e))
          .toList(),
      // stops: (map['stops'] as List<dynamic>)
      //     .map((dynamic station) => Station.fromMap(station))
      //     .toList(),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      '_id': rid,
      'source': source.toMap(),
      'destination': destination.toMap(),
      'stops': stops.map((Station station) => station.toMap()).toList(),
    };
  }

  @override
  List<Object?> get props => [
        rid,
        source,
        destination,
        stops,
      ];
}
