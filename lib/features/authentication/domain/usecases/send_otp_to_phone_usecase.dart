import 'package:dartz/dartz.dart';

import '../../../../../core/errors/failure.dart';
import '../repositories/user_repository.dart';

class SendOTPToPhoneUseCase {
  final UserRepository userRepository;

  SendOTPToPhoneUseCase(this.userRepository);

  Future<Either<Failure, int?>> call({required String phone}) async {
    return userRepository.sendOTPToPhone(phone);
  }
}
