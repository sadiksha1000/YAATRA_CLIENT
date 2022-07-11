import 'package:dartz/dartz.dart';
import '../../../../../core/errors/failure.dart';
import '../entities/agent.dart';

class ApplyAsAgentRepository {
  Future<Either<Failure, Agent>> call({
    required String uid,
    required String name,
    required String phone,
    required String address,
    required List<String> documentUrl,
  }) async {
    return const Right(Agent.empty);
  }

  Future<Either<Failure, Agent>> refreshApplyAsAgent({
    required String aid,
  }) async {
    return const Right(Agent.empty);
  }
}
