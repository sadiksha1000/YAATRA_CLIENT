import 'package:equatable/equatable.dart';
import '../../../trips/domain/entities/conductor.dart';
import '../../../trips/domain/entities/facilities.dart';
import '../../../trips/domain/entities/owner.dart';
import '../../../trips/domain/entities/routes.dart';
import '../../../trips/domain/entities/seat.dart';

class Bus extends Equatable {
  final String id;
  final Owner ownerId;
  final Conductor conductorId;
  final String name;
  final String plateNumber;
  final int ticketPrice;
  final bool isRefundable;
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
    required this.conductorId,
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
    conductorId: Conductor.empty,
    name: '',
    plateNumber: '',
    ticketPrice: 0,
    isRefundable: false,
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
      // ownerId: map['ownerId'].map((owner) => Owner.fromMap(owner)).toList(),
      ownerId: Owner.fromMap(map['ownerId']),
      // counductorId: map['conductorId']
      //     .map((conductor) => Conductor.fromMap(conductor))
      //     .toList(),
      conductorId: Conductor.fromMap(map['conductorId']),
      name: map['name'] ?? '',
      plateNumber: map['plateNumber'] ?? '',
      ticketPrice: map['ticketPrice'] ?? 0,
      isRefundable: map['isRefundable'] ?? false,
      step1: map['step1'] ?? false,
      step2: map['step2'] ?? false,
      step3: map['step3'] ?? false,
      isVerified: map['isVerified'] ?? false,
      facilities: (map['facilities'] as List<dynamic>)
          .map((dynamic facility) => Facilities.fromMap(facility))
          .toList(),
      // routes: map['routeId'].map((routes) => Routes.fromMap(routes)).toList(),
      routes: Routes.fromMap(map['routeId']),
      seats: (map['seats'] as List<dynamic>)
          .map((dynamic seat) => Seat.fromMap(seat))
          .toList(),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      '_id': id,
      'ownerId': ownerId.toMap(),
      'conductorId': conductorId.toMap(),
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
        conductorId,
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
