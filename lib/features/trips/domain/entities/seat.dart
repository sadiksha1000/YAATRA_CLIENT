import 'package:equatable/equatable.dart';

class Seat extends Equatable {
  final int position;
  final String seatId;
  final String busId;
  final String label;
  final int ticketPrice;
  final bool isAvailable;
  final bool isActive;
  final String message;

  const Seat({
    required this.busId,
    required this.isActive,
    required this.isAvailable,
    required this.label,
    required this.seatId,
    required this.ticketPrice,
    required this.message,
    required this.position,
  });

  static const empty = Seat(
      busId: '',
      isActive: false,
      isAvailable: false,
      label: '',
      seatId: '',
      ticketPrice: 0,
      message: '',
      position: 0);

  bool get isEmpty => this == Seat.empty;
  bool get isNotEmpty => this != Seat.empty;

  factory Seat.fromMap(Map<String, dynamic> map) {
    return Seat(
      busId: map['busId'] ?? '',
      isActive: map['isActive'] ?? false,
      isAvailable: map['isAvailable'] ?? false,
      label: map['label'] ?? '',
      seatId: map['_id'] ?? '',
      ticketPrice: map['ticketPrice'] ?? '',
      message: map['message'] ?? '',
      position: map['position'] ?? 0,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      '_id': seatId,
      'busId': busId,
      'label': label,
      'ticketPrice': ticketPrice,
      'isAvailable': isAvailable,
      'isActive': isActive,
      'message': message,
      'position': position,
    };
  }

  @override
  List<Object?> get props => [
        busId,
        isActive,
        isAvailable,
        label,
        seatId,
        ticketPrice,
        message,
        position,
      ];
}
