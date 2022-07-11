import 'dart:convert';

import 'package:equatable/equatable.dart';
import 'user.dart';

class Owner extends Equatable {
  final User uid;
  final String name;
  final String address;
  final String phone;
  final String documentUrl;
  final bool isVerified;
  final String profileUrl;

  const Owner({
    required this.uid,
    required this.phone,
    required this.name,
    required this.address,
    required this.documentUrl,
    required this.isVerified,
    required this.profileUrl,
  });

  static const empty = Owner(
    uid: User.empty,
    phone: '',
    name: '',
    address: '',
    documentUrl: '',
    isVerified: false,
    profileUrl: '',
  );

  @override
  List<Object?> get props => [
        uid,
        phone,
        name,
        address,
        documentUrl,
        isVerified,
        profileUrl,
      ];

  Map<String, dynamic> toMap() {
    return {
      'uid': uid.toMap(),
      'name': name,
      'address': address,
      'phone': phone,
      'documentUrl': documentUrl,
      'isVerified': isVerified,
      'profileUrl': profileUrl,
    };
  }

  factory Owner.fromMap(Map<String, dynamic> map) {
    return Owner(
      uid: User.fromMap(map['uid']),
      // uid: map['uid'].map((user) => User.fromMap(user)).toList(),
      name: map['name'] ?? '',
      address: map['address'] ?? '',
      phone: map['phone'] ?? '',
      documentUrl: map['documentUrl'] ?? '',
      isVerified: map['isVerified'] ?? false,
      profileUrl: map['profileUrl'] ?? '',
    );
  }
}
