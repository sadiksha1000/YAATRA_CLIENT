import 'dart:convert';

import '../../../../authentication/data/models/user_model.dart';
import '../../../../authentication/domain/entities/user.dart';
import '../../domain/entities/agent.dart';

class AgentModel extends Agent {
  const AgentModel({
    required final User uid,
    required final String aid,
    required final String name,
    required final String address,
    required final String photo,
    required final String documentUrl,
    required final bool isVerified,
    required final String profileUrl,
    required final String phone,
    required final String message,
  }) : super(
          aid: aid,
          name: name,
          address: address,
          photo: photo,
          uid: uid,
          documentUrl: documentUrl,
          isVerified: isVerified,
          profileUrl: profileUrl,
          phone: phone,
          message: message,
        );

  static const empty = AgentModel(
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

  bool get isEmpty => this == AgentModel.empty;
  bool get isNotEmpty => this != AgentModel.empty;

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

  factory AgentModel.fromMap(Map<String, dynamic> map) {
    return AgentModel(
      uid: UserModel.fromMap(map['uid']),
      aid: map['_id'] ?? '',
      name: map['name'] ?? '',
      address: map['address'] ?? '',
      photo: map['photo'] ?? '',
      documentUrl: map['documentUrl'] ?? '',
      isVerified: map['isVerified'] ?? false,
      profileUrl: map['profileUrl'] ?? '',
      phone: map['phone'] ?? '',
      message: map['message'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory AgentModel.fromJson(String source) =>
      AgentModel.fromMap(json.decode(source)['data']);
}
