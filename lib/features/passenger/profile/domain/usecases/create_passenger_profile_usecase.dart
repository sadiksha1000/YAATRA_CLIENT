import 'package:dartz/dartz.dart';
import 'package:yaatra_client/features/passenger/profile/domain/enities/passenger_profile.dart';

import '../../../../../core/errors/failure.dart';
import '../repositories/passenger_profile_repositories.dart';

class CreateProfileUseCase {
  final PassengerProfileRepository profileRepository;

  CreateProfileUseCase({required this.profileRepository});

  Future<Either<Failure, PassengerProfile>> call(
    PassengerProfile pProfile,
  ) async {
    return await profileRepository.createProfile(pProfile);
  }
}
