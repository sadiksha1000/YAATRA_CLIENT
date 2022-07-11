import 'dart:io';

import 'package:dartz/dartz.dart';

import '../../../../../core/errors/failure.dart';
import '../../../../../core/network/network_info.dart';
import '../models/upload_image_model.dart';
import '../../domain/repositories/image_repository.dart';

import '../datasources/upload_image_remote_datasource.dart';

class ImageRepositoryImpl implements ImageRepository {
  UploadImageRemoteDataSource uploadImageRemoteDataSource;
  NetworkInfo networkInfo;
  ImageRepositoryImpl({
    required this.uploadImageRemoteDataSource,
    required this.networkInfo,
  });
  @override
  Future<Either<Failure, UploadImageModel>> uploadImages(
      {required List<File> uploadImages}) async {
    if (await networkInfo.isConnected) {
      return Right(await uploadImageRemoteDataSource.uploadImages(
          uploadImages: uploadImages));
    } else {
      return Left(
        ServerFailure(
          properties: [],
          message: "Please connect with internet",
        ),
      );
    }
  }
}
