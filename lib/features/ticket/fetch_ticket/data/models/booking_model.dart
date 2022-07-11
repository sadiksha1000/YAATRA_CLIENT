import 'dart:convert';

import '../../../../trips/domain/entities/booked_seats.dart';
import '../../../../trips/domain/entities/trip.dart';
import '../../../../trips/domain/entities/user.dart';
import '../../domain/entities/booking.dart';

class BookingModel extends Booking {
  // BookedSeats left
  const BookingModel({
    required String id,
    required Trip tripId,
    required User userId,
    required String name,
    required String phone,
    required String email,
    required int totalAmount,
    // required List<BookedSeats> bookedSeats,
    required String message,
  }) : super(
          id: id,
          tripId: tripId,
          userId: userId,
          name: name,
          phone: phone,
          email: email,
          totalAmount: totalAmount,
          message: message,
        );

  static final empty = BookingModel(
      id: '',
      tripId: Trip.empty,
      userId: User.empty,
      name: '',
      phone: '',
      email: '',
      totalAmount: 0,
      // bookedSeats: [],
      message: '');

  factory BookingModel.fromMap(Map<String, dynamic> map,
      {required String message}) {
    return BookingModel(
        id: map['_id'],
        tripId: Trip.fromMap(map['tripId']),
        userId: User.fromMap(map['userId']),
        name: map['name'],
        phone: map['phone'],
        email: map['email'],
        totalAmount: map['totalAmount'] ?? 0,
        // bookedSeats: (map['bookedSeats'] as List<dynamic>)
        //     .map((e) => BookedSeats.fromMap(e))
        //     .toList(),
        message: '');
  }

  Map<String, dynamic> toMap() {
    return {
      '_id': id,
      'tripId': tripId.toMap(),
      'userId': userId.toMap(),
      'name': name,
      'phone': phone,
      'email': email,
      'totalAmount': totalAmount,
      // 'bookedSeats': bookedSeats.map((BookedSeats seats) => seats.toMap()),
      'message': message
    };
  }

  String toJson() => json.encode(toMap());
}
