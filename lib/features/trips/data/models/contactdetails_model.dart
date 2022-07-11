import 'dart:convert';

import '../../domain/entities/contactdetails.dart';

class ContactDetailsModel extends ContactDetails {
  const ContactDetailsModel({
    required String name,
    required String phone,
    required String email,
  }) : super(
          name: name,
          phone: phone,
          email: email,
        );

  static const empty = ContactDetailsModel(
    name: '',
    phone: '',
    email: '',
  );

  bool get isEmpty => this == ContactDetailsModel.empty;
  bool get isNotEmpty => this != ContactDetailsModel.empty;

  factory ContactDetailsModel.fromMap(Map<String, dynamic> map) {
    return ContactDetailsModel(
      name: map['name'],
      phone: map['phone'],
      email: map['email'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'phone': phone,
      'email': email,
    };
  }

  String toJson() => json.encode(toMap());
}
