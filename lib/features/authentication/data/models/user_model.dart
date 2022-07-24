import 'dart:convert';

import '../../domain/entities/user.dart';

class UserModel extends User {
  const UserModel({
    required String uid,
    required String phone,
    required bool isAgent,
    required bool isPassenger,
    required String activeRole,
    required String accessToken,
    required String message,
  }) : super(
          uid: uid,
          phone: phone,
          isAgent: isAgent,
          isPassenger: isPassenger,
          activeRole: activeRole,
          accessToken: accessToken,
          message: message,
        );

  static const empty = UserModel(
      uid: '',
      phone: '',
      accessToken: '',
      activeRole: '',
      isPassenger: false,
      isAgent: false,
      message: '');

  bool get isEmpty => this == UserModel.empty;
  bool get isNotEmpty => this != UserModel.empty;

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

  /// Used to map remote data source
  ///
  ///
  /// {success: true, message: "User logged in successfully", data: {_id: "fkjshfjh", isAgent: false}}
  factory UserModel.fromMap(Map<String, dynamic> map, {String? message}) {
    return UserModel(
      uid: map['_id'] ?? '',
      phone: map['phone'] ?? '',
      isAgent: map['isAgent'] ?? false,
      isPassenger: map['isPassenger'] ?? false,
      activeRole: map['activeRole'] ?? '',
      accessToken: map['accessToken'] ?? '',
      message: message ?? '',
    );
  }

  /// Used to map state data
  /// {uid:'sdfisj', phone:'98934857'}
  factory UserModel.fromLocalMap(Map<String, dynamic> map) {
    return UserModel(
      uid: map['uid'] ?? '',
      phone: map['phone'] ?? '',
      isAgent: map['isAgent'] ?? false,
      isPassenger: map['isPassenger'] ?? false,
      activeRole: map['activeRole'] ?? '',
      accessToken: map['accessToken'] ?? '',
      message: map['message'] ?? '',
    );
  }

  @override
  String toJson() => json.encode(toMap());


}
