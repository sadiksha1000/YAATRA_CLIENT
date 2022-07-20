import 'package:dartz/dartz.dart';
import 'package:yaatra_client/features/trips/data/models/trip_model.dart';
import '../datasources/fetch_ticket_remote_datasource.dart';
import '../../domain/repositories/fetch_ticket_repository.dart';

import '../../../../../core/errors/failure.dart';
import '../../../../../core/network/network_info.dart';
import '../../domain/entities/booking.dart';
import '../models/booking_model.dart';


class FetchTicketRepositoryImpl implements FetchTicketRepository{
    final FetchTicketRemoteDataSource remoteDataSource;
    final NetworkInfo networkInfo;

    FetchTicketRepositoryImpl({
        required this.remoteDataSource,
        required this.networkInfo
    });

    @override
    var currentBooking = Booking.empty;

    @override
    Future<Either<Failure,List<BookingModel>>> fetchAllBookings({
      required String userId
    })async{
      if (await networkInfo.isConnected){
        try{
          final bookingDetails=await remoteDataSource.fetchAllTickets(userId: userId);
          return Right(bookingDetails);
        } on ServerFailure catch(e){
          return Left(e);
        }
      }else{
        return Left(CacheFailure(properties: []));
      }
    }

    @override
  Future<Either<Failure, TripModel>> fetchTrip(
      {required String tripId}) async {
    if (await networkInfo.isConnected) {
      try {
        final tripDetails =
            await remoteDataSource.fetchTrip(tripId: tripId);
        return Right(tripDetails);
      } on ServerFailure catch (e) {
        return Left(e);
      }
    } else {
      return Left(CacheFailure(properties: []));
    }
  }
}