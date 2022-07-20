import 'package:yaatra_client/features/trips/domain/entities/trip_seat.dart';

class PassengerDetailsModel {
  final String name;
  final String contact;
  final TripSeat seat;
  final String email;

  const PassengerDetailsModel({
    required this.name,
    required this.contact,
    required this.seat,
    required this.email,
  });

  static const empty = PassengerDetailsModel(
    name: '',
    contact: '',
    seat: TripSeat.empty,
    email: '',
  );
  //copy with
  PassengerDetailsModel copyWith({
    String? name,
    String? contact,
    TripSeat? seat,
    String? email,
  }) {
    return PassengerDetailsModel(
      name: name ?? this.name,
      contact: contact ?? this.contact,
      seat: seat ?? this.seat,
      email: email ?? this.email,
    );
  }
}
