import 'package:dartz/dartz.dart';

import '../../../../../core/errors/failure.dart';
import '../entities/user.dart';
import '../repositories/user_repository.dart';

class SwitchUserRoleUseCase {
  final UserRepository userRepository;

  SwitchUserRoleUseCase(this.userRepository);

  Future<Either<Failure, User>> call({
    required String uid,
    required String activeRole,
  }) async {
    return userRepository.switchUser(uid: uid, activeRole:activeRole);
  } 
}
