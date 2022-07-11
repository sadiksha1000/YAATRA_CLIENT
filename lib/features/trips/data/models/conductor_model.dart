import 'dart:convert';

import '../../domain/entities/conductor.dart';
import '../../domain/entities/user.dart';

class ConductorModel extends Conductor {
  const ConductorModel({
    required final String cid,
    required final String name,
    required final String address,
    required final String photo,
    required final User uid,
  }) : super(
          cid: cid,
          name: name,
          address: address,
          photo: photo,
          uid: uid,
        );

  // static const empty = ConductorModel(
  //   cid: '',
  //   name: '',
  //   address: '',
  //   photo: '',
  //   uid: User.empty,
  // );

  // bool get isEmpty => this == ConductorModel.empty;
  // bool get isNotEmpty => this != ConductorModel.empty;

  Map<String, dynamic> toMap() {
    return {
      '_id': cid,
      'name': name,
      'address': address,
      'photo': photo,
      'uid': uid.toMap(),
    };
  }

  factory ConductorModel.fromMap(Map<String, dynamic> map) {
    return ConductorModel(
      uid: User.fromMap(map['uid']),
      cid: map['_id'] ?? '',
      name: map['name'] ?? '',
      address: map['address'] ?? '',
      photo: map['photo'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory ConductorModel.fromJson(String source) =>
      ConductorModel.fromMap(json.decode(source)['data']);
}
