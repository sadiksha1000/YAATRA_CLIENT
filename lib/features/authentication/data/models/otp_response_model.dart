import 'package:yaatra_client/features/authentication/domain/entities/otp_response.dart';

class OtpResponseModel extends OtpResponse {
  const OtpResponseModel({
    required String hash,
    required String message,
  }) : super(hash: hash, message: message);

  static const empty = OtpResponseModel(
    hash: '',
    message: '',
  );

  @override
  bool get isEmpty => this == OtpResponse.empty;
  @override
  bool get isNotEmpty => this != OtpResponse.empty;

  @override
  List<Object?> get props => [
        hash,
        message,
      ];

  @override
  Map<String, dynamic> toMap() {
    return {
      'hash': hash,
      'message': message,
    };
  }

  factory OtpResponseModel.fromMap(Map<String, dynamic> map) {
    return OtpResponseModel(
      hash: map['hash'] ?? '',
      message: map['message'] ?? '',
    );
  }
}
