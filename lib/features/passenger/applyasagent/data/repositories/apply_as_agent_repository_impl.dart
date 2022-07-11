import '../../../../../core/network/network_info.dart';
import '../../../../../core/errors/failure.dart';
import 'package:dartz/dartz.dart';

import '../../domain/entities/agent.dart';
import '../../domain/repositories/apply_as_agent_repository.dart';
import '../datasources/apply_as_agent_remote_datasource.dart';

class ApplyAsAgentRepositoryImpl implements ApplyAsAgentRepository {
  final ApplyAsAgentRemoteDataSource remoteDataSource;
  final NetworkInfo networkInfo;

  ApplyAsAgentRepositoryImpl({
    required this.remoteDataSource,
    required this.networkInfo,
  });

  @override
  Future<Either<Failure, Agent>> call(
      {required String uid,
      required String name,
      required String phone,
      required String address,
      required List<String> documentUrl}) async {
    if (await networkInfo.isConnected) {
      try {
        final ownerDetails = await remoteDataSource.applyAsAgent(
            name: name,
            phone: phone,
            address: address,
            documentUrl: documentUrl,
            uid: uid);
        // perform caching only when it gets things from server successfully
        return Right(ownerDetails);
      } on ServerFailure catch (e) {
        return Left(e);
      }
    } else {
      return Left(CacheFailure(properties: []));
    }
  }

  @override
  Future<Either<Failure, Agent>> refreshApplyAsAgent(
      {required String aid}) async {
    if (await networkInfo.isConnected) {
      try {
        final ownerDetails =
            await remoteDataSource.refreshApplyAsAgent(aid: aid);
        // perform caching only when it gets things from server successfully
        return Right(ownerDetails);
      } on ServerFailure catch (e) {
        return Left(e);
      }
    } else {
      return Left(CacheFailure(properties: []));
    }
  }
  
}
