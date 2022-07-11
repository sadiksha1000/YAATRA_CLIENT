import 'package:equatable/equatable.dart';

class User extends Equatable {
  final String uid;
  final String phone;
  final bool isPassenger;
  final bool isAgent;
  final String activeRole;
  final String accessToken;
  final String message;

  const User({
    required this.uid,
    required this.phone,
    required this.isPassenger,
    required this.isAgent,
    required this.activeRole,
    required this.accessToken,
    required this.message,
  });

  static const empty = User(
    uid: '',
    phone: '',
    isPassenger: false,
    isAgent: false,
    activeRole: '',
    accessToken: '',
    message: '',
  );

  bool get isEmpty => this == User.empty;
  bool get isNotEmpty => this != User.empty;

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

  factory User.fromMap(Map<String, dynamic> map) {
    return User(
      uid: map['data']['_id'] ?? '',
      phone: map['data']['phone'] ?? '',
      isPassenger: map['data']['isPassenger'] ?? false,
      isAgent: map['data']['isAgent'] ?? false,
      activeRole: map['activeRole'] ?? '',
      accessToken: map['accessToken'] ?? '',
      message: map['message'] ?? '',
    );
  }

  factory User.fromLocalMap(Map<String, dynamic> map) {
    return User(
      uid: map['uid'] ?? '',
      phone: map['phone'] ?? '',
      isPassenger: map['isPassenger'] ?? false,
      isAgent: map['isAgent'] ?? false,
      activeRole: map['activeRole'] ?? '',
      accessToken: map['accessToken'] ?? '',
      message: map['message'] ?? '',
    );
  }

  @override
  List<Object> get props => [
        uid,
        phone,
        isPassenger,
        isAgent,
        activeRole,
        accessToken,
        message,
      ];
}
