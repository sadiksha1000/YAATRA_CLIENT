import 'dart:convert';

import 'package:equatable/equatable.dart';
import '../../domain/entities/facilities.dart';

class FacilitiesModel extends Facilities {
  const FacilitiesModel({
    required String fid,
    required String iconName,
    required String facilityName,
  }) : super(
          fid: fid,
          iconName: iconName,
          facilityName: facilityName,
        );

  static const empty = FacilitiesModel(
    fid: '',
    iconName: '',
    facilityName: '',
  );

  bool get isEmpty => this == FacilitiesModel.empty;
  bool get isNotEmpty => this != FacilitiesModel.empty;

  Map<String, dynamic> toMap() {
    return {
      '_id': fid,
      'iconName': iconName,
      'facilityName': facilityName,
    };
  }

  factory FacilitiesModel.fromMap(Map<String, dynamic> map) {
    return FacilitiesModel(
      fid: map['_id'] ?? '',
      iconName: map['iconName'] ?? '',
      facilityName: map['facilityName'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory FacilitiesModel.fromJson(String source) =>
      FacilitiesModel.fromMap(json.decode(source)['data']);
}
