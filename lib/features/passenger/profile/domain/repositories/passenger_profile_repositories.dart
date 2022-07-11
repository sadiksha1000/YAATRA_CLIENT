import 'package:dartz/dartz.dart';
import '../../../../../core/errors/failure.dart';
import '../../../../authentication/data/models/user_model.dart';
import '../enities/passenger_profile.dart';

class PassengerProfileRepository {
  // var currentUser = PassengerProfile.empty;

  Future<Either<Failure, PassengerProfile>> createProfile(
      PassengerProfile pProfile) async {
    print("Profileatrepo${pProfile}");
    return const Right(PassengerProfile.empty);
  }

  Future<Either<Failure, PassengerProfile>> getCurrentPassenger(
      {required String uid}) async {
    return const Right(PassengerProfile.empty);
  }

  Future<Either<Failure, List<PassengerProfile>>> fetchAllPassenger() async {
    throw UnimplementedError();
  }
}
