import 'package:dartz/dartz.dart';

import '../../../../../core/errors/failure.dart';
import '../entities/user.dart';
import '../repositories/user_repository.dart';

class LoginUserUseCase {
  final UserRepository userRepository;

  LoginUserUseCase(this.userRepository);

  Future<Either<Failure, User>> call({
    required String phone,
    required String password,
  }) async {
    return userRepository.loginUser(phone: phone, password: password);
  }
}
