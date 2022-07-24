import 'package:dartz/dartz.dart';

import '../../../../../core/errors/failure.dart';
import '../entities/user.dart';

class UserRepository {
  var currentUser = User.empty;

  Future<Either<Failure, int?>> sendOTPToPhone(String phone) async {
    return const Right(1);
  }

  Future<Either<Failure, User>> registerUser(
      {required String phone, required String password}) async {
    return const Right(User.empty);
  }

  Future<Either<Failure, User>> loginUser(
      {required String phone, required String password}) async {
    return const Right(User.empty);
  }

  Future<Either<Failure, User>> refreshCurrentUser(
      {required String uid}) async {
    return const Right(User.empty);
  }

  Future<Either<Failure, User>> switchUser(
      {required String uid, required String activeRole}) async {
    return const Right(User.empty);
  }

  Future<void>? logout(String uid) {}
}
