import 'dart:convert';
import '../../domain/entities/conductor.dart';

import '../../../bus/domain/entities/bus.dart';
import '../../domain/entities/facilities.dart';
import '../../domain/entities/owner.dart';
import '../../domain/entities/routes.dart';
import '../../domain/entities/seat.dart';

class BusModel extends Bus {
  const BusModel({
    required String id,
    required Owner ownerId,
    required Conductor conductorId,
    required String name,
    required String plateNumber,
    required int ticketPrice,
    required bool isRefundable,
    required bool step1,
    required bool step2,
    required bool step3,
    required bool isVerified,
    required List<Facilities> facilities,
    required Routes routes,
    required List<Seat> seats,
  }) : super(
          id: id,
          ownerId: ownerId,
          conductorId: conductorId,
          name: name,
          plateNumber: plateNumber,
          ticketPrice: ticketPrice,
          isRefundable: isRefundable,
          step1: step1,
          step2: step2,
          step3: step3,
          isVerified: isVerified,
          facilities: facilities,
          routes: routes,
          seats: seats,
        );

  static const empty = BusModel(
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

  bool get isEmpty => this == BusModel.empty;
  bool get isNotEmpty => this != BusModel.empty;

  factory BusModel.fromMap(Map<String, dynamic> map) {
    return BusModel(
      id: map['_id'] ?? '',
      ownerId: Owner.fromMap(map['ownerId']),
      conductorId: Conductor.fromMap(map['conductorId']),
      name: map['name'] ?? '',
      plateNumber: map['plateNumber'] ?? '',
      ticketPrice: map['ticketPrice'] ?? '',
      isRefundable: map['isRefundable'] ?? false,
      step1: map['step1'] ?? false,
      step2: map['step2'] ?? false,
      step3: map['step3'] ?? false,
      isVerified: map['isVerified'] ?? false,
      facilities: (map['facilities'] as List)
          .map((facilities) => Facilities.fromMap(facilities))
          .toList(),
      routes: Routes.fromMap(map['routes']),
      seats: (map['seats'] as List).map((seat) => Seat.fromMap(seat)).toList(),
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
      'facilities': facilities.map((facilities) => facilities.toMap()).toList(),
      'routes': routes.toMap(),
      'seats': seats.map((seat) => seat.toMap()).toList(),
    };
  }

  String toJson() => json.encode(toMap());

  factory BusModel.fromJson(String source) =>
      BusModel.fromMap(json.decode(source)['data']);
}
