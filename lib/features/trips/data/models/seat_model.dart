import 'dart:convert';

import '../../domain/entities/seat.dart';

class SeatModel extends Seat {
  const SeatModel(
      {required String busId,
      required bool isActive,
      required bool isAvailable,
      required String label,
      required String seatId,
      required int ticketPrice,
      required String message,
      required int position})
      : super(
          busId: busId,
          isActive: isActive,
          isAvailable: isAvailable,
          label: label,
          seatId: seatId,
          ticketPrice: ticketPrice,
          message: message,
          position: position,
        );

  static const empty = SeatModel(
    busId: '',
    isActive: false,
    isAvailable: false,
    label: '',
    seatId: '',
    ticketPrice: 0,
    message: '',
    position: 0,
  );

  bool get isEmpty => this == SeatModel.empty;
  bool get isNotEmpty => this != SeatModel.empty;

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

  factory SeatModel.fromMap(Map<String, dynamic> map) {
    return SeatModel(
      seatId: map['_id'] ?? '',
      busId: map['busId'] ?? '',
      label: map['label'] ?? '',
      ticketPrice: map['ticketPrice'] ?? 0,
      isAvailable: map['isAvailable'] ?? false,
      isActive: map['isActive'] ?? false,
      message: map['message'] ?? '',
      position: map['position'] ?? 0,
    );
  }

  String toJson() => json.encode(toMap());

  factory SeatModel.fromJson(String source) =>
      SeatModel.fromMap(json.decode(source)['data']);
}
