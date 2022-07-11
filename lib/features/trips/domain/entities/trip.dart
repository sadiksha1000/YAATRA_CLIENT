import 'package:equatable/equatable.dart';
import 'package:yaatra_client/features/trips/domain/entities/routes.dart';
import '../../../ticket/fetch_ticket/domain/entities/booking.dart';
import 'conductor.dart';
import 'customroute.dart';

import '../../../bus/domain/entities/bus.dart';

class Trip extends Equatable {
  final String id;
  final Bus busId;
  final Routes departureRoute;
  final DateTime departureTime;
  final DateTime arrivalTime;
  final DateTime tripStartDate;
  final DateTime tripEndDate;
  // final Booking booking;
  final String message;

  Trip({
    required this.id,
    required this.busId,
    required this.departureRoute,
    required this.departureTime,
    required this.arrivalTime,
    required this.tripStartDate,
    required this.tripEndDate,
    required this.message,
  });

  static final empty = Trip(
    id: '',
    busId: Bus.empty,
    departureRoute: Routes.empty,
    departureTime: DateTime.now(),
    arrivalTime: DateTime.now(),
    tripStartDate: DateTime.now(),
    tripEndDate: DateTime.now(),
    // booking: Booking.empty,
    message: '',
  );

  factory Trip.fromMap(Map<String, dynamic> map) {
    return Trip(
      id: map['_id'],
      busId: Bus.fromMap(map['busId']),
      departureRoute: Routes.fromMap(map['departureRoute']),
      departureTime: map['departureTime'] ?? DateTime.now(),
      arrivalTime: map['arrivalTime'] ?? DateTime.now(),
      tripStartDate: DateTime.tryParse(map['tripStartDate']) ?? DateTime.now(),
      tripEndDate: DateTime.tryParse(map['tripEndDate']) ?? DateTime.now(),
      // booking: Booking.fromMap(map['booking']),
      message: map['message'] ?? '',
    );
  }

  Map<String, dynamic> toMap() {
    return {
      '_id': id,
      'busId': busId.toMap(),
      'departureRoute': departureRoute.toMap(),
      'departureTime': departureTime,
      'arrivalTime': arrivalTime,
      'tripStartDate': tripStartDate,
      'tripEndDate': tripEndDate,
      // 'booking': booking.toMap(),
    };
  }

  @override
  List<Object> get props => [
        id,
        busId,
        departureRoute,
        departureTime,
        arrivalTime,
        tripStartDate,
        tripEndDate,
        // booking,
      ];
}
