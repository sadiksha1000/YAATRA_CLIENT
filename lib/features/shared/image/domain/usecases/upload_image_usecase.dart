import 'dart:io';

import 'package:dartz/dartz.dart';

import '../../../../../core/errors/failure.dart';
import '../entities/upload_image.dart';
import '../repositories/image_repository.dart';

class UploadImagesUseCase {
  ImageRepository imageRepository;
  UploadImagesUseCase({
    required this.imageRepository,
  });

  Future<Either<Failure, UploadImage>> call(
      {required List<File> uploadImages}) {
    return imageRepository.uploadImages(uploadImages: uploadImages);
  }
}
