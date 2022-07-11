import 'dart:convert';

import '../../domain/entities/booked_seats.dart';

import '../../domain/entities/seat.dart';

class BookedSeatsModel extends BookedSeats {
  const BookedSeatsModel({
    required Seat seatId,
    required String name,
    required String phone,
  }) : super(
          seatId: seatId,
          name: name,
          phone: phone,
        );

  static const empty = BookedSeatsModel(
    seatId: Seat.empty,
    name: '',
    phone: '',
  );

  bool get isEmpty => this == BookedSeatsModel.empty;
  bool get isNotEmpty => this != BookedSeatsModel.empty;

  factory BookedSeatsModel.fromMap(Map<String, dynamic> map) {
    return BookedSeatsModel(
      seatId: Seat.fromMap(map['seatId']),
      name: map['name'],
      phone: map['phone'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'seatId': seatId.toMap(),
      'name': name,
      'phone': phone,
    };
  }

  String toJson() => json.encode(toMap());

  factory BookedSeatsModel.fromJson(String source) =>
      BookedSeatsModel.fromMap(json.decode(source)['data']);
}
