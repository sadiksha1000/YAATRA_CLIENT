import 'package:equatable/equatable.dart';
import 'seat.dart';

class BookedSeats extends Equatable {
  final Seat seatId;
  final String name;
  final String phone;

  const BookedSeats({
    required this.seatId,
    required this.name,
    required this.phone,
  });

  static const empty = BookedSeats(
    seatId: Seat.empty,
    name: '',
    phone: '',
  );

  factory BookedSeats.fromMap(Map<String, dynamic> map) {
    return BookedSeats(
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

  @override
  List<Object> get props => [
        seatId,
        name,
        phone,
      ];
}
