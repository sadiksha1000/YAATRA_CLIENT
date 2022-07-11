
import 'dart:io';

import 'package:dartz/dartz.dart';

import '../../../../../core/errors/failure.dart';
import '../entities/upload_image.dart';

class ImageRepository {
  Future<Either<Failure, UploadImage>> uploadImages(
      {required List<File> uploadImages}) async {
    return const Right(UploadImage.empty);
  }
}
