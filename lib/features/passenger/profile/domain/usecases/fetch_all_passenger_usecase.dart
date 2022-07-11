import 'package:dartz/dartz.dart';
import 'package:yaatra_client/features/passenger/profile/domain/enities/passenger_profile.dart';
import 'package:yaatra_client/features/passenger/profile/domain/repositories/passenger_profile_repositories.dart';

import '../../../../../core/errors/failure.dart';

class fetchAllPassengerUseCase {
  PassengerProfileRepository passengerProfileRepository;

  fetchAllPassengerUseCase(this.passengerProfileRepository);

  Future<Either<Failure, List<PassengerProfile>>> call() async {
    return passengerProfileRepository.fetchAllPassenger();
  }
}
