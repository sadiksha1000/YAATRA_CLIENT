import 'dart:convert';
import '../../domain/entities/owner.dart';
import '../../domain/entities/user.dart';

class OwnerModel extends Owner {
  const OwnerModel({
    required final User uid,
    required final String name,
    required final String address,
    required final String phone,
    required final String documentUrl,
    required final bool isVerified,
    required final String profileUrl,
  }) : super(
          uid: uid,
          name: name,
          address: address,
          phone: phone,
          documentUrl: documentUrl,
          isVerified: isVerified,
          profileUrl: profileUrl,
        );

  static const empty = OwnerModel(
    uid: User.empty,
    name: '',
    address: '',
    phone: '',
    documentUrl: '',
    isVerified: false,
    profileUrl: '',
  );

  bool get isEmpty => this == OwnerModel.empty;
  bool get isNotEmpty => this != OwnerModel.empty;

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

  factory OwnerModel.fromMap(Map<String, dynamic> map) {
    return OwnerModel(
      uid: User.fromMap(map['uid']),
      name: map['name'] ?? '',
      address: map['address'] ?? '',
      phone: map['phone'] ?? '',
      documentUrl: map['documentUrl'] ?? '',
      isVerified: map['isVerified'] ?? false,
      profileUrl: map['profileUrl'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory OwnerModel.fromJson(String source) =>
      OwnerModel.fromMap(json.decode(source)['data']);
}
