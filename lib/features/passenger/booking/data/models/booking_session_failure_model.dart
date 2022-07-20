import 'package:yaatra_client/features/trips/domain/entities/trip_seat.dart';

class BookingSessionFailureModel {
  final List<TripSeat> unAvailableSeats;
  final String message;

  const BookingSessionFailureModel({
    required this.message,
    required this.unAvailableSeats,
  });

  static const empty = BookingSessionFailureModel(
    message: '',
    unAvailableSeats: [],
  );
  //copy with
  BookingSessionFailureModel copyWith({
    String? message,
    List<TripSeat>? unAvailableSeats,
  }) {
    return BookingSessionFailureModel(
      message: message ?? this.message,
      unAvailableSeats: unAvailableSeats ?? this.unAvailableSeats,
    );
  }

  // from json
  factory BookingSessionFailureModel.fromJson(Map<String, dynamic> json) {
    return BookingSessionFailureModel(
      message: json['message'] as String,
      unAvailableSeats: (json['unAvailableSeats'] as List<dynamic>)
          .map((e) => TripSeat.fromMap(e))
          .toList(),
    );
  }
}
