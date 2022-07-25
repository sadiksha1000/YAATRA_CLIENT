

import 'package:equatable/equatable.dart';

class OtpResponse extends Equatable {
  final String hash;
  final String message;

  const OtpResponse({
    required this.hash,
    required this.message,
  });

  static const empty = OtpResponse(
    hash: '',
    message: '',
  );

  bool get isEmpty => this == OtpResponse.empty;
  bool get isNotEmpty => this != OtpResponse.empty;

  @override
  List<Object?> get props => [
        hash,
        message,
      ];

  Map<String, dynamic> toMap() {
    return {
      'hash': hash,
      'message': message,
    };
  }

  factory OtpResponse.fromMap(Map<String, dynamic> map) {
    return OtpResponse(
      hash: map['hash'] ?? '',
      message: map['message'] ?? '',
    );
  }
  
  
}
