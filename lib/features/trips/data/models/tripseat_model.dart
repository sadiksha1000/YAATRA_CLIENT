import 'dart:convert';

import '../../domain/entities/seat.dart';
import '../../domain/entities/trip_seat.dart';



class TripSeatModel extends TripSeat {
  const TripSeatModel({
    required String id,
    required Seat seat,
    required bool isAvailable,
    required bool isBooked,
    required bool isHolded,
  }) : super(
          id: id,
          seat: seat,
          isAvailable: isAvailable,
          isBooked: isBooked,
          isHolded: isHolded,
        );

  static const empty = TripSeatModel(
    id: '',
    seat: Seat.empty,
    isAvailable: false,
    isBooked: false,
    isHolded: false,
  );

  bool get isEmpty => this == TripSeatModel.empty;
  bool get isNotEmpty => this != TripSeatModel.empty;

  factory TripSeatModel.fromMap(Map<String, dynamic> map) {
    return TripSeatModel(
      id: map['_id'],
      seat: Seat.fromMap(map['seat']),
      isAvailable: map['isAvailable'],
      isBooked: map['isBooked'],
      isHolded: map['isHolded'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      '_id': id,
      'seat': seat.toMap(),
      'isAvailable': isAvailable,
      'isBooked': isBooked,
      'isHolded': isHolded,
    };
  }

  String toJson() => json.encode(toMap());

  factory TripSeatModel.fromJson(String source) =>
      TripSeatModel.fromMap(json.decode(source)['data']);
}
