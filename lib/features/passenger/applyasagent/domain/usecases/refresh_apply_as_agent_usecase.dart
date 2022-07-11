import 'package:dartz/dartz.dart';

import '../../../../../core/errors/failure.dart';
import '../entities/agent.dart';
import '../repositories/apply_as_agent_repository.dart';

class RefreshApplyAsAgentUseCase {
  final ApplyAsAgentRepository agentDashboardRepository;

  RefreshApplyAsAgentUseCase(this.agentDashboardRepository);

  Future<Either<Failure, Agent>> call({
    required String aid,
  }) async {
    return agentDashboardRepository.refreshApplyAsAgent(
      aid: aid,
    );
  }
}
