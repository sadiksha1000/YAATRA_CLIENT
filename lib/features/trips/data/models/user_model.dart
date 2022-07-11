import 'dart:convert';

import '../../domain/entities/user.dart';

class UserModel extends User {
  const UserModel({
    required String uid,
    required String phone,
    required bool isOwner,
    required bool isConductor,
    required String activeRole,
    required String accessToken,
    required String message,
  }) : super(
          uid: uid,
          phone: phone,
          isOwner: isOwner,
          isConductor: isConductor,
          activeRole: activeRole,
          accessToken: accessToken,
          message: message,
        );

  static const empty = UserModel(
      uid: '',
      phone: '',
      accessToken: '',
      activeRole: '',
      isConductor: false,
      isOwner: false,
      message: '');

  bool get isEmpty => this == UserModel.empty;
  bool get isNotEmpty => this != UserModel.empty;

  Map<String, dynamic> toMap() {
    return {
      '_id': uid,
      'phone': phone,
      'isOwner': isOwner,
      'isConductor': isConductor,
      'activeRole': activeRole,
      'accessToken': accessToken,
      'message': message,
    };
  }

  /// Used to map remote data source
  ///
  ///
  /// {success: true, message: "User logged in successfully", data: {_id: "fkjshfjh", isOwner: false}}
  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
      uid: map['_id'] ?? '',
      phone: map['phone'] ?? '',
      isOwner: map['isOwner'] ?? false,
      isConductor: map['isConductor'] ?? false,
      activeRole: map['activeRole'] ?? '',
      accessToken: map['accessToken'] ?? '',
      message: map['message'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory UserModel.fromJson(String source) =>
      UserModel.fromMap(json.decode(source)['data']);
}
