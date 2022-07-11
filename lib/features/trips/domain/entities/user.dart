import 'dart:convert';

import 'package:equatable/equatable.dart';

class User extends Equatable {
  final String uid;
  final String phone;
  final bool isOwner;
  final bool isConductor;
  final String activeRole;
  final String accessToken;
  final String message;

  const User({
    required this.uid,
    required this.phone,
    required this.isOwner,
    required this.isConductor,
    required this.activeRole,
    required this.accessToken,
    required this.message,
  });

  static const empty = User(
      uid: '',
      phone: '',
      accessToken: '',
      activeRole: '',
      isConductor: false,
      isOwner: false,
      message: '');

  bool get isEmpty => this == User.empty;
  bool get isNotEmpty => this != User.empty;

  @override
  List<Object?> get props => [
        uid,
        phone,
        isOwner,
        isConductor,
        activeRole,
        accessToken,
      ];

  Map<String, dynamic> toMap() {
    return {
      'uid': uid,
      'phone': phone,
      'isOwner': isOwner,
      'isConductor': isConductor,
      'activeRole': activeRole,
      'accessToken': accessToken,
      'message': message,
    };
  }

  factory User.fromMap(Map<String, dynamic> map) {
    return User(
      uid: map['uid'] ?? '',
      phone: map['phone'] ?? '',
      isOwner: map['isOwner'] ?? false,
      isConductor: map['isConductor'] ?? false,
      activeRole: map['activeRole'] ?? '',
      accessToken: map['accessToken'] ?? '',
      message: map['message'] ?? '',
    );
  }
  factory User.fromLocalMap(Map<String, dynamic> map) {
    return User(
      uid: map['uid'] ?? '',
      phone: map['phone'] ?? '',
      isOwner: map['isOwner'] ?? false,
      isConductor: map['isConductor'] ?? false,
      activeRole: map['activeRole'] ?? '',
      accessToken: map['accessToken'] ?? '',
      message: map['message'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory User.fromJson(String source) => User.fromMap(json.decode(source));
}
