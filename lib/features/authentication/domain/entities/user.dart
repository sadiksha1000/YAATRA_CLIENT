import 'dart:convert';

import 'package:equatable/equatable.dart';

class User extends Equatable {
  final String uid;
  final String phone;
  final bool isAgent;
  final bool isPassenger;
  final String activeRole;
  final String accessToken;
  final String message;

  const User({
    required this.uid,
    required this.phone,
    required this.isAgent,
    required this.isPassenger,
    required this.activeRole,
    required this.accessToken,
    required this.message,
  });

  static const empty = User(
      uid: '',
      phone: '',
      accessToken: '',
      activeRole: '',
      isPassenger: false,
      isAgent: false,
      message: '');

  bool get isEmpty => this == User.empty;
  bool get isNotEmpty => this != User.empty;

  @override
  List<Object?> get props => [
        uid,
        phone,
        isAgent,
        isPassenger,
        activeRole,
        accessToken,
      ];

  Map<String, dynamic> toMap() {
    return {
      'uid': uid,
      'phone': phone,
      'isAgent': isAgent,
      'isPassenger': isPassenger,
      'activeRole': activeRole,
      'accessToken': accessToken,
      'message': message,
    };
  }

  factory User.fromMap(Map<String, dynamic> map) {
    return User(
      uid: map['data']['uid'] ?? '',
      phone: map['data']['phone'] ?? '',
      isAgent: map['data']['isAgent'] ?? false,
      isPassenger: map['data']['isPassenger'] ?? false,
      activeRole: map['data']['activeRole'] ?? '',
      accessToken: map['accessToken'] ?? '',
      message: map['message'] ?? '',
    );
  }
  factory User.fromLocalMap(Map<String, dynamic> map) {
    return User(
      uid: map['uid'] ?? '',
      phone: map['phone'] ?? '',
      isAgent: map['isAgent'] ?? false,
      isPassenger: map['isPassenger'] ?? false,
      activeRole: map['activeRole'] ?? '',
      accessToken: map['accessToken'] ?? '',
      message: map['message'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory User.fromJson(String source) => User.fromMap(json.decode(source));
}
