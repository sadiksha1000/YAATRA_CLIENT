import 'dart:convert';

import '../../domain/entities/user.dart';

class UserModel extends User {
  const UserModel({
    required String uid,
    required String phone,
    required bool isPassenger,
    required bool isAgent,
    required String activeRole,
    required String accessToken,
    required String message,
  }) : super(
          uid: uid,
          phone: phone,
          isPassenger: isPassenger,
          isAgent: isAgent,
          activeRole: activeRole,
          accessToken: accessToken,
          message: message,
        );

  static const empty = UserModel(
    uid: '',
    phone: '',
    isPassenger: false,
    isAgent: false,
    activeRole: '',
    accessToken: '',
    message: '',
  );

  bool get isEmpty => this == UserModel.empty;
  bool get isNotEmpty => this != UserModel.empty;

  Map<String, dynamic> toMap() {
    return {
      'uid': uid,
      'phone': phone,
      'isPassenger': isPassenger,
      'isAgent': isAgent,
      'activeRole': activeRole,
      'accessToken': accessToken,
      'message': message,
    };
  }

  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
      uid: map['_id'] ?? '',
      phone: map['phone'] ?? '',
      isPassenger: map['isPassenger'] ?? false,
      isAgent: map['isAgent'] ?? false,
      activeRole: map['activeRole'] ?? '',
      accessToken: map['accessToken'] ?? '',
      message: map['message'] ?? '',
    );
  }

  factory UserModel.fromLocalMap(Map<String, dynamic> map) {
    return UserModel(
      uid: map['uid'] ?? '',
      phone: map['phone'] ?? '',
      isPassenger: map['isPassenger'] ?? false,
      isAgent: map['isAgent'] ?? false,
      activeRole: map['activeRole'] ?? '',
      accessToken: map['accessToken'] ?? '',
      message: map['message'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  // factory UserModel.fromJson(String source) =>
  //     UserModel.fromMap(json.decode(source));
}
