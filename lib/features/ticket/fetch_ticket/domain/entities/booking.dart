import 'package:equatable/equatable.dart';
import '../../../../trips/domain/entities/booked_seats.dart';
import '../../../../trips/domain/entities/trip.dart';
import '../../../../trips/domain/entities/user.dart';

class Booking extends Equatable {
  final String id;
  final Trip tripId;
  final User userId;
  final String name;
  final String phone;
  final String email;
  final int totalAmount;
  // final List<BookedSeats> bookedSeats;
  final String message;

  const Booking({
    required this.id,
    required this.tripId,
    required this.userId,
    required this.name,
    required this.phone,
    required this.email,
    required this.totalAmount,
    // required this.bookedSeats,
    required this.message,
  });

  static final empty = Booking(
      id: '',
      tripId: Trip.empty,
      userId: User.empty,
      name: '',
      phone: '',
      email: '',
      totalAmount: 0,
      // bookedSeats: [],
      message: '');

  factory Booking.fromMap(Map<String, dynamic> map) {
    return Booking(
        id: map['_id'],
        tripId: map['tripId'],
        userId: User.fromMap(map['userId']),
        name: map['name'],
        phone: map['phone'],
        email: map['email'],
        totalAmount: map['totalAmount'],
        // bookedSeats: (map['bookedSeats'] as List<dynamic>)
        //     .map((e) => BookedSeats.fromMap(e))
        //     .toList(),
        message: map['message']);
  }

  Map<String, dynamic> toMap() {
    return {
      '_id': id,
      'tripId': tripId,
      'userId': userId.toMap(),
      'name': name,
      'phone': phone,
      'email': email,
      'totalAmount': totalAmount,
      // 'bookedSeats': bookedSeats.map((BookedSeats seats) => seats.toMap()),
      'message': message
    };
  }

  @override
  List<Object> get props => [
        id,
        tripId,
        userId,
        name,
        phone,
        email,
        totalAmount,
        // bookedSeats,
        message
      ];
}
