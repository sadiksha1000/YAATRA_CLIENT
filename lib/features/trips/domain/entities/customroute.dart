import 'package:equatable/equatable.dart';
import '../../../bus/domain/entities/bus.dart';
import 'station.dart';

class CustomRoute extends Equatable {
  final String id;
  final Station source;
  final Station destination;
  final List<Station> stops;
  final String busId;

  const CustomRoute({
    required this.id,
    required this.busId,
    required this.source,
    required this.destination,
    required this.stops,
  });

  static const empty = CustomRoute(
    id: '',
    busId: '',
    source: Station.empty,
    destination: Station.empty,
    stops: [],
  );

  factory CustomRoute.fromMap(Map<String, dynamic> map) {
    return CustomRoute(
      id: map['_id'],
      busId: map['busId'],
      source: Station.fromMap(map['source']),
      destination: Station.fromMap(map['destination']),
      stops: (map['stops'] as List<dynamic>)
          .map((e) => Station.fromMap(e))
          .toList(),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      '_id': id,
      'busId': busId,
      'source': source.toMap(),
      'destination': destination.toMap(),
      'stops': (List<dynamic>.from(stops.map((x) => x.toMap()))),
    };
  }

  @override
  List<Object> get props => [
        id,
        busId,
        source,
        destination,
        stops,
      ];
}
