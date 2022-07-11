import 'dart:convert';

import '../../../../authentication/data/models/user_model.dart';
import '../../../../authentication/domain/entities/user.dart';
import '../../domain/enities/passenger_profile.dart';

class PassengerProfileModel extends PassengerProfile {
  const PassengerProfileModel(
      {required User uid,
      required String pId,
      required String phone,
      required String name,
      required String profileUrl,
      required String address,
      required String message})
      : super(
            uid: uid,
            pId: pId,
            phone: phone,
            name: name,
            profileUrl: profileUrl,
            address: address,
            message: message);

  static const empty = PassengerProfileModel(
      uid: UserModel.empty,
      pId: '',
      phone: '',
      name: '',
      profileUrl: '',
      address: '',
      message: '');

  bool get isEmpty => this == PassengerProfileModel.empty;
  bool get isNotEmpty => this != PassengerProfileModel.empty;

  @override
  List<Object> get props =>
      [uid, pId, phone, name, address, profileUrl, message];

  factory PassengerProfileModel.fromMap(Map<String, dynamic> map,
      {required String message}) {
    print("atmap");
    print(map);
    return PassengerProfileModel(
      uid: UserModel.fromMap(map['uid']),
      pId: map['_id'] ?? '',
      phone: map['phone'] ?? '',
      name: map['name'] ?? '',
      profileUrl: map['profileUrl'] ?? '',
      address: map['address'] ?? '',
      message: message,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'uid': uid,
      '_id': pId,
      'phone': phone,
      'name': name,
      'profileUrl': profileUrl,
      'address': address,
      'message': message
    };
  }

  @override
  PassengerProfile copyWith(
      {User? uid,
      String? pId,
      String? name,
      String? phone,
      String? profileUrl,
      String? address,
      String? message}) {
    return PassengerProfile(
        uid: uid ?? this.uid,
        pId: pId ?? this.pId,
        name: name ?? this.name,
        phone: phone ?? this.phone,
        profileUrl: profileUrl ?? this.profileUrl,
        address: address ?? this.address,
        message: message ?? this.message);
  }

  String toJson() => json.encode(toMap());

  factory PassengerProfileModel.fromJson(String source) =>
      PassengerProfileModel.fromMap(json.decode(source), message: '');
}
