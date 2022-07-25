import 'package:dartz/dartz.dart';
import 'package:yaatra_client/features/authentication/data/models/otp_response_model.dart';

import '../../../../../core/errors/failure.dart';
import '../repositories/user_repository.dart';

class SendOTPToPhoneUseCase {
  final UserRepository userRepository;

  SendOTPToPhoneUseCase(this.userRepository);

  Future<Either<Failure, OtpResponseModel>> call({required String phone}) async {
    return userRepository.sendOTPToPhone(phone);
  }
}
