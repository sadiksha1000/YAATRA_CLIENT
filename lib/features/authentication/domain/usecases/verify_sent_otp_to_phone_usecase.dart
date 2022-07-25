import 'package:dartz/dartz.dart';
import 'package:yaatra_client/features/authentication/data/models/otp_response_model.dart';

import '../../../../../core/errors/failure.dart';
import '../repositories/user_repository.dart';

class VerifySentOTPToPhoneUseCase {
  final UserRepository userRepository;

  VerifySentOTPToPhoneUseCase(this.userRepository);

  Future<Either<Failure, OtpResponseModel>> call(
      {required String phone,
      required String hash,
      required String otp}) async {
    return userRepository.verifySentOTPToPhone(
        phone: phone, hash: hash, otp: otp);
  }
}
