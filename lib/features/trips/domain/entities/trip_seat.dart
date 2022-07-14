import 'package:equatable/equatable.dart';
import 'package:yaatra_client/features/trips/domain/entities/seat.dart';


class TripSeat extends Equatable {
  final String id;
  final Seat seat;
  final bool isAvailable;
  final bool isBooked;
  final bool isHolded;

  const TripSeat({
    required this.id,
    required this.seat,
    required this.isAvailable,
    required this.isBooked,
    required this.isHolded,
  });

  static const empty = TripSeat(
    id: '',
    seat: Seat.empty,
    isAvailable: false,
    isBooked: false,
    isHolded: false,
  );

  factory TripSeat.fromMap(Map<String, dynamic> map) {
    return TripSeat(
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

  @override
  List<Object> get props => [
        id,
        seat,
        isAvailable,
        isBooked,
        isHolded,
      ];
}
