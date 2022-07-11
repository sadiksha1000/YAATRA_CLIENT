import 'package:equatable/equatable.dart';

class ContactDetails extends Equatable {
  final String name;
  final String phone;
  final String email;

  const ContactDetails({
    required this.name,
    required this.phone,
    required this.email,
  });

  static const empty = ContactDetails(
    name: '',
    phone: '',
    email: '',
  );

  factory ContactDetails.fromMap(Map<String, dynamic> map) {
    return ContactDetails(
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

  @override
  List<Object> get props => [
        name,
        phone,
        email,
      ];
}
