import 'package:dartz/dartz.dart';

import '../../../../../core/errors/failure.dart';
import '../entities/user.dart';
import '../repositories/user_repository.dart';

class RefreshCurrentUserUseCase {
  final UserRepository userRepository;

  RefreshCurrentUserUseCase(this.userRepository);

  Future<Either<Failure, User>> execute({
    required String uid,
  }) async {

    return userRepository.refreshCurrentUser(uid: uid);
  }
}
