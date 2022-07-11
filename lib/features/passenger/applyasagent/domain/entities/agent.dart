import 'package:equatable/equatable.dart';

import '../../../../authentication/domain/entities/user.dart';

class Agent extends Equatable {
  final String aid;
  final String name;
  final String address;
  final String photo;
  final User uid;
  final String documentUrl;
  final bool isVerified;
  final String profileUrl;
  final String phone;
  final String message;

  const Agent({
    required this.aid,
    required this.name,
    required this.address,
    required this.photo,
    required this.uid,
    required this.documentUrl,
    required this.isVerified,
    required this.profileUrl,
    required this.phone,
    required this.message,
  });

  static const empty = Agent(
    aid: '',
    name: '',
    address: '',
    photo: '',
    uid: User.empty,
    documentUrl: '',
    isVerified: false,
    profileUrl: '',
    phone: '',
    message: '',
  );

  factory Agent.fromMap(Map<String, dynamic> map) {
    return Agent(
      aid: map['_id'] ?? '',
      name: map['name'] ?? '',
      address: map['address'] ?? '',
      photo: map['photo'] ?? '',
      uid: User.fromMap(map['uid']),
      documentUrl: map['documentUrl'] ?? '',
      isVerified: map['isVerified'] ?? false,
      profileUrl: map['profileUrl'] ?? '',
      phone: map['phone'] ?? '',
      message: map['message'] ?? '',
    );
  }

  Map<String, dynamic> toMap() {
    return {
      '_id': aid,
      'name': name,
      'address': address,
      'photo': photo,
      'uid': uid.toMap(),
      'documentUrl': documentUrl,
      'isVerified': isVerified,
      'profileUrl': profileUrl,
      'phone': phone,
      'message': message,
    };
  }

  @override
  List<Object?> get props => [
        aid,
        name,
        address,
        photo,
        uid,
        documentUrl,
        isVerified,
        profileUrl,
        phone,
        message,
      ];
}
