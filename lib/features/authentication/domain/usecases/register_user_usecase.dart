import 'package:dartz/dartz.dart';

import '../../../../../core/errors/failure.dart';
import '../entities/user.dart';
import '../repositories/user_repository.dart';

class RegisterUserUseCase {
  final UserRepository userRepository;

  RegisterUserUseCase({required this.userRepository});

  Future<Either<Failure, User>> call({
    required String phone,
    required String password,
  }) async {
    return await userRepository.registerUser(phone: phone, password: password);
  }
}
