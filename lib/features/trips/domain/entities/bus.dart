
import 'package:equatable/equatable.dart';
import 'conductor.dart';
import 'facilities.dart';
import 'owner.dart';
import 'routes.dart';
import 'seat.dart';

class Bus extends Equatable {
  final String id;
  final Owner ownerId;
  final Conductor counductorId;
  final String name;
  final String plateNumber;
  final String ticketPrice;
  final String isRefundable;
  final bool step1;
  final bool step2;
  final bool step3;
  final bool isVerified;
  final List<Facilities> facilities;
  final Routes routes;
  final List<Seat> seats;

  const Bus({
    required this.id,
    required this.ownerId,
    required this.counductorId,
    required this.name,
    required this.plateNumber,
    required this.ticketPrice,
    required this.isRefundable,
    required this.step1,
    required this.step2,
    required this.step3,
    required this.isVerified,
    required this.facilities,
    required this.routes,
    required this.seats,
  });

  static const empty = Bus(
    id: '',
    ownerId: Owner.empty,
    counductorId: Conductor.empty,
    name: '',
    plateNumber: '',
    ticketPrice: '',
    isRefundable: '',
    step1: false,
    step2: false,
    step3: false,
    isVerified: false,
    facilities: [],
    routes: Routes.empty,
    seats: [],
  );

  factory Bus.fromMap(Map<String, dynamic> map) {
    return Bus(
      id: map['_id'] ?? '',
      ownerId: Owner.fromMap(map['ownerId']),
      counductorId: Conductor.fromMap(map['counductorId']),
      name: map['name'] ?? '',
      plateNumber: map['plateNumber'] ?? '',
      ticketPrice: map['ticketPrice'] ?? '',
      isRefundable: map['isRefundable'] ?? '',
      step1: map['step1'] ?? false,
      step2: map['step2'] ?? false,
      step3: map['step3'] ?? false,
      isVerified: map['isVerified'] ?? false,
      facilities: (map['facilities'] as List<dynamic>)
          .map((dynamic facility) => Facilities.fromMap(facility))
          .toList(),
      routes: Routes.fromMap(map['routes']),
      seats: (map['seats'] as List<dynamic>)
          .map((dynamic seat) => Seat.fromMap(seat))
          .toList(),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      '_id': id,
      'ownerId': ownerId.toMap(),
      'counductorId': counductorId.toMap(),
      'name': name,
      'plateNumber': plateNumber,
      'ticketPrice': ticketPrice,
      'isRefundable': isRefundable,
      'step1': step1,
      'step2': step2,
      'step3': step3,
      'isVerified': isVerified,
      'facilities': facilities.map((facility) => facility.toMap()).toList(),
      'routes': routes.toMap(),
      'seats': seats.map((seat) => seat.toMap()).toList(),
    };
  }

  @override
  List<Object?> get props => [
        id,
        ownerId,
        counductorId,
        name,
        plateNumber,
        ticketPrice,
        isRefundable,
        step1,
        step2,
        step3,
        isVerified,
        facilities,
        routes,
        seats,
      ];
}
