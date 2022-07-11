import 'package:dartz/dartz.dart';
import '../entities/agent.dart';

import '../../../../../core/errors/failure.dart';
import '../repositories/apply_as_agent_repository.dart';

class ApplyAsAgentUseCase {
  final ApplyAsAgentRepository agentDashboardRepository;

  ApplyAsAgentUseCase(this.agentDashboardRepository);

  Future<Either<Failure, Agent>> call({
    required String uid,
    required String name,
    required String phone,
    required String address,
    required List<String> documentUrl,
  }) async {
    return agentDashboardRepository(
      address: address,
      documentUrl: documentUrl,
      name: name,
      phone: phone,
      uid: uid,
    );
  }
}
