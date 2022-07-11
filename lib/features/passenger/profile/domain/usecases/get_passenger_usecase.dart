import 'package:dartz/dartz.dart';
import 'package:yaatra_client/features/passenger/profile/domain/enities/passenger_profile.dart';

import '../../../../../core/errors/failure.dart';
import '../../../../authentication/domain/entities/user.dart';
import '../repositories/passenger_profile_repositories.dart';

class GetCurrentPassengerUsecase {
  final PassengerProfileRepository passengerProfileRepository;

  GetCurrentPassengerUsecase(this.passengerProfileRepository);

  Future<Either<Failure, PassengerProfile>> call({
    required String uid,
  }) async {
    return passengerProfileRepository.getCurrentPassenger(uid: uid);
  }
}
