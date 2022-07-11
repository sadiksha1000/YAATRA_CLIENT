import 'package:equatable/equatable.dart';

import '../../../../authentication/data/models/user_model.dart';
import '../../../../authentication/domain/entities/user.dart';

class PassengerProfile extends Equatable {
  final User uid;
  final String pId;
  final String name;
  final String phone;
  final String profileUrl;
  final String address;
  final String message;

  const PassengerProfile(
      {required this.uid,
      required this.pId,
      required this.name,
      required this.phone,
      required this.profileUrl,
      required this.address,
      required this.message});

  static const empty = PassengerProfile(
      uid: UserModel.empty,
      pId: '',
      name: '',
      profileUrl: '',
      address: '',
      phone: '',
      message: '');

  bool get isEmpty => this == PassengerProfile.empty;
  bool get isNotEmpty => this != PassengerProfile.empty;

  PassengerProfile copyWith({
    User? uid,
    String? pId,
    String? name,
    String? profileUrl,
    String? address,
    String? phone,
    String? message,
  }) {
    return PassengerProfile(
        uid: uid ?? this.uid,
        pId: pId ?? this.pId,
        name: name ?? this.name,
        phone: phone ?? this.phone,
        profileUrl: profileUrl ?? this.profileUrl,
        address: address ?? this.address,
        message: message ?? this.message);
  }

  @override
  List<Object> get props =>
      [uid, pId, name, profileUrl, address, phone, message];
}
