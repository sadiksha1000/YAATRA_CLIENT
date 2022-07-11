import 'dart:convert';

import '../../domain/entities/place.dart';

import '../../domain/entities/station.dart';

class PlaceModel extends Place{
  const PlaceModel({
    required String pid,
    required String name,
  }) : super(
        pid: pid,
        name: name,
      );

  static const empty = PlaceModel(
    pid: '',
    name: '',
  );

  bool get isEmpty => this == PlaceModel.empty;
  bool get isNotEmpty => this != PlaceModel.empty;

  Map<String, dynamic> toMap() {
    return {
      '_id': pid,
      'name': name,
    };
  }

  factory PlaceModel.fromMap(Map<String, dynamic> map) {
    return PlaceModel(
      pid: map['_id'] ?? '',
      name: map['name'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());
}