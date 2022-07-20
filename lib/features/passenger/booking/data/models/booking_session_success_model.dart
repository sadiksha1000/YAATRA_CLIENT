import 'package:yaatra_client/features/trips/domain/entities/trip_seat.dart';

class BookingSessionSuccessModel {
  final String id;
  final DateTime bookingStartedAt;
  final List<String> selectedSeats;
  final String tripId;
  final String userId;

  const BookingSessionSuccessModel({
    required this.id,
    required this.bookingStartedAt,
    required this.selectedSeats,
    required this.tripId,
    required this.userId,
  });

  static final empty = BookingSessionSuccessModel(
    id: '',
    bookingStartedAt: DateTime.now(),
    selectedSeats: [],
    tripId: '',
    userId: '',
  );
  //copy with
  BookingSessionSuccessModel copyWith({
    String? id,
    DateTime? bookingStartedAt,
    List<String>? selectedSeats,
    String? tripId,
    String? userId,
    List<String>? unAvailableSeats,
  }) {
    return BookingSessionSuccessModel(
      id: id ?? this.id,
      bookingStartedAt: bookingStartedAt ?? this.bookingStartedAt,
      selectedSeats: selectedSeats ?? this.selectedSeats,
      tripId: tripId ?? this.tripId,
      userId: userId ?? this.userId,
    );
  }

  // from map
  factory BookingSessionSuccessModel.fromMap(Map<String, dynamic> json) {
    return BookingSessionSuccessModel(
      id: json['_id'],
      bookingStartedAt: DateTime.parse(json['bookingStartedAt'] as String),
      selectedSeats: (json['selectedSeats'] as List<dynamic>)
          .map((e) => e.toString())
          .toList(),
      tripId: json['tripId'] as String,
      userId: json['userId'] ?? '',
    );
  }
}
