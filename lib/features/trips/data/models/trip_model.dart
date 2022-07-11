import 'dart:convert';

import 'package:dartz/dartz_unsafe.dart';

import '../../../bus/domain/entities/bus.dart';
import '../../../ticket/fetch_ticket/domain/entities/booking.dart';
import '../../domain/entities/conductor.dart';
import '../../domain/entities/customroute.dart';
import '../../domain/entities/routes.dart';
import '../../domain/entities/trip.dart';

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
  }) : super(
          id: id,
          busId: busId,
          departureRoute: departureRoute,
          departureTime: departureTime,
          arrivalTime: arrivalTime,
          tripStartDate: tripStartDate,
          tripEndDate: tripEndDate,
          message: message,
        );

  static final empty = TripModel(
    id: '',
    busId: Bus.empty,
    departureRoute: Routes.empty,
    departureTime: DateTime.now(),
    arrivalTime: DateTime.now(),
    tripStartDate: DateTime.now(),
    tripEndDate: DateTime.now(),
    message: '',
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
    };
  }

  static TripModel fromMap(Map<String, dynamic> map,
      {required String message}) {
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
    );
  }

  String toJson() => json.encode(toMap());
}
