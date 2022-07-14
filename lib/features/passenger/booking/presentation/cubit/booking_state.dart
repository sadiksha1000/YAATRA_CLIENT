part of 'booking_cubit.dart';

class BookingState extends Equatable {
  final Status refreshSelectedTripStatus;
  final List<dynamic> allTripSeats;
  final Trip selectedTrip;
  final List<TripSeat> selectedSeatsByUser;
  final int totalPrice;

  const BookingState({
    required this.allTripSeats,
    required this.selectedTrip,
    required this.refreshSelectedTripStatus,
    required this.selectedSeatsByUser,
    required this.totalPrice,
  });

  @override
  List<Object> get props => [
        allTripSeats,
        selectedTrip,
        refreshSelectedTripStatus,
        selectedSeatsByUser,
        totalPrice
      ];

  factory BookingState.initial() {
    return BookingState(
      allTripSeats: [],
      selectedTrip: Trip.empty,
      refreshSelectedTripStatus: Status.initial,
      selectedSeatsByUser: [],
      totalPrice: 0,
    );
  }

  BookingState copyWith({
    List<dynamic>? allTripSeats,
    Trip? selectedTrip,
    Status? refreshSelectedTripStatus,
    List<TripSeat>? selectedSeatsByUser,
    int? totalPrice,
  }) {
    return BookingState(
      allTripSeats: allTripSeats ?? this.allTripSeats,
      selectedTrip: selectedTrip ?? this.selectedTrip,
      refreshSelectedTripStatus:
          refreshSelectedTripStatus ?? this.refreshSelectedTripStatus,
      selectedSeatsByUser: selectedSeatsByUser ?? this.selectedSeatsByUser,
      totalPrice: totalPrice ?? this.totalPrice,
    );
  }
}
