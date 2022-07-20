import 'dart:convert';

import '../../../bus/domain/entities/bus.dart';

import '../../domain/entities/routes.dart';
import '../../domain/entities/trip.dart';
import '../../domain/entities/trip_seat.dart';

class TripModel extends Trip {
  // Booking ko add garne remaining
  TripModel({
    required String id,
    required Bus busId,
    required Routes departureRoute,
    required DateTime departureTime,
    required DateTime arrivalTime,
    required DateTime tripStartDate,
    required DateTime tripEndDate,
    required String message,
    required List<dynamic> allTripSeats,
  }) : super(
            id: id,
            busId: busId,
            departureRoute: departureRoute,
            departureTime: departureTime,
            arrivalTime: arrivalTime,
            tripStartDate: tripStartDate,
            tripEndDate: tripEndDate,
            message: message,
            allTripSeats: allTripSeats);

  static final empty = TripModel(
    id: '',
    busId: Bus.empty,
    departureRoute: Routes.empty,
    departureTime: DateTime.now(),
    arrivalTime: DateTime.now(),
    tripStartDate: DateTime.now(),
    tripEndDate: DateTime.now(),
    message: '',
    allTripSeats: [],
  );

  bool get isEmpty => this == TripModel.empty;
  bool get isNotEmpty => this != TripModel.empty;

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'busId': busId.toMap(),
      'departureRoute': departureRoute.toMap(),
      'departureTime': departureTime,
      'arrivalTime': arrivalTime,
      'tripStartDate': tripStartDate,
      'tripEndDate': tripEndDate,
      // 'booking': booking.toMap(),
      'seats': allTripSeats.map((e) => e.toMap()).toList(),
    };
  }

  static TripModel fromMap(Map<String, dynamic> map,
      {required String message}) {
    // print("This is map of trip seats ${map['seats']}");
    // print("This is map of departure time ${map['departureTime']}");
    // print("This is map of arival time${map['arrivalTime']}");
    // print("This is map of trip start date ${map['tripStartDate']}");
    List<dynamic> seats = [];
    map['seats'].forEach((seat) {
      if (seat == null) {
        seats.add(null);
      } else {
        seats.add(TripSeat.fromMap(seat));
      }
    });

    print("This is map of all trip $seats");
    return TripModel(
      id: map['_id'],
      busId: Bus.fromMap(map['busId']),
      departureRoute: Routes.fromMap(map['departureRoute']),
      departureTime: DateTime.tryParse(map['departureTime']) ?? DateTime.now(),
      arrivalTime: DateTime.tryParse(map['arrivalTime']) ?? DateTime.now(),
      tripStartDate: DateTime.tryParse(map['tripStartDate']) ?? DateTime.now(),
      tripEndDate: DateTime.tryParse(map['tripEndDate']) ?? DateTime.now(),
      // booking:
      //     map['booking'].map((booking) => Booking.fromMap(booking)).toList(),
      message: message,
      allTripSeats: seats,
    );
  }

  String toJson() => json.encode(toMap());
}
